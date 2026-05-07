# -*- coding: utf-8 -*-
"""
InProShop 工程导入脚本 (兼容版)
用法：
- 在 InProShop 中打开同一个工程 -> 工具 -> 执行脚本 -> 选择本文件
- 或在空 InProShop 中执行本脚本；脚本会从自身所在目录查找唯一 .project 并打开

功能：
- 读取 _exported 目录下的 .txt/.st 文件
- 按工程树路径找到对应的 POU / GVL / DUT / Action
- 更新已有对象的声明和实现代码
- 支持创建新的 POU / GVL / DUT / Action 对象

注意：
- 执行前请先备份工程！(另存为或复制 .project 文件)
- 导入后必须在 InProShop 中编译验证
"""

from __future__ import print_function
import os
import sys
import re
import datetime
import codecs

from scriptengine import projects, system

# ============================================================================
# 配置
# ============================================================================

ENCODING = 'utf-8'

# 是否在导入前弹窗确认 (软件集成流程会先准备 _exported 并记录日志，这里直接执行)
CONFIRM_BEFORE_IMPORT = False

# 是否允许创建新对象 (True=创建, False=仅更新已有)
ALLOW_CREATE_NEW = True

# 只导入这些目录下的文件 (留空则导入全部)
# 例如: ['OP10', '0.Struct'] 只导入 OP10 和 0.Struct 下的文件
FILTER_DIRS = []

# 跳过这些文件
SKIP_FILES = ['_export_log.txt', '_io_mapping.csv', '_project_info.txt', '_import_log.txt']


# ============================================================================
# 工具函数
# ============================================================================

def read_text_file(file_path):
    """读取文件内容"""
    with codecs.open(file_path, 'r', encoding=ENCODING) as f:
        return f.read()


def write_log(log_path, log_lines):
    """写入日志"""
    with codecs.open(log_path, 'w', encoding=ENCODING) as f:
        f.write('\n'.join(log_lines))


def get_script_directory():
    """尽量获取脚本所在目录；InProShop ScriptEngine 有些版本不可靠支持 __file__。"""
    candidates = []
    try:
        candidates.append(os.path.dirname(os.path.abspath(__file__)))
    except:
        pass
    try:
        if sys.argv and sys.argv[0]:
            candidates.append(os.path.dirname(os.path.abspath(sys.argv[0])))
    except:
        pass
    try:
        candidates.append(os.getcwd())
    except:
        pass

    for path in candidates:
        if path and os.path.isdir(path):
            return path
    return ''


def find_project_next_to_script(log_lines):
    """从脚本所在目录查找唯一 .project 文件。"""
    script_dir = get_script_directory()
    if not script_dir:
        log_lines.append("[ERR] Cannot resolve script directory.")
        return None

    project_files = []
    try:
        for name in os.listdir(script_dir):
            if name.lower().endswith('.project'):
                project_files.append(os.path.join(script_dir, name))
    except Exception as e:
        log_lines.append("[ERR] Cannot list script directory %s: %s" % (script_dir, str(e)))
        return None

    if len(project_files) == 1:
        return project_files[0]

    if len(project_files) == 0:
        log_lines.append("[ERR] No .project file found next to script: %s" % script_dir)
    else:
        log_lines.append("[ERR] Multiple .project files found next to script: %s" % script_dir)
        for path in project_files:
            log_lines.append("      - %s" % path)
    return None


def open_project_if_needed(log_lines):
    """
    返回当前工程；若当前为空，则打开脚本同目录唯一 .project。
    这样可支持空 InProShop 执行脚本后写入对应 .project。
    """
    try:
        proj = projects.primary
        if proj:
            log_lines.append("[INFO] Using opened project: %s" % getattr(proj, 'path', '<unknown>'))
            return proj
    except:
        pass

    project_path = find_project_next_to_script(log_lines)
    if not project_path:
        return None

    log_lines.append("[INFO] No project open. Opening project: %s" % project_path)

    # 不同 InProShop/CODESYS 版本的 projects.open 签名可能不同，依次尝试。
    open_attempts = (
        lambda: projects.open(project_path),
        lambda: projects.open(project_path, primary=True),
        lambda: projects.open(project_path, True)
    )
    for attempt in open_attempts:
        try:
            opened = attempt()
            if opened:
                return opened
            proj = projects.primary
            if proj:
                return proj
        except Exception as e:
            log_lines.append("[WARN] projects.open attempt failed: %s" % str(e))

    log_lines.append("[ERR] Failed to open project: %s" % project_path)
    return None


def detect_file_type(content, file_name):
    """
    根据文件内容判断类型
    返回: 'pou', 'gvl', 'dut', 'action'
    """
    stripped = content.strip()
    upper = stripped.upper()

    # DUT: TYPE xxx :
    if upper.startswith('TYPE ') or (upper.startswith('{ATTRIBUTE') and '\nTYPE ' in upper):
        return 'dut'

    # POU: FUNCTION_BLOCK / PROGRAM / FUNCTION
    if (upper.startswith('FUNCTION_BLOCK ') or
        upper.startswith('PROGRAM ') or
        upper.startswith('FUNCTION ')):
        return 'pou'

    # GVL: VAR_GLOBAL
    if upper.startswith('VAR_GLOBAL'):
        return 'gvl'

    # Action: 没有上述头部关键字，纯实现代码
    return 'action'


def split_pou_decl_impl(content):
    """
    把 POU 文件拆成声明和实现两部分
    规则：最后一个 END_VAR 之前(含)是声明，之后是实现
    """
    lines = content.split('\n')
    last_end_var = -1
    for i, line in enumerate(lines):
        if line.strip().upper() == 'END_VAR':
            last_end_var = i

    if last_end_var == -1:
        # 没有 END_VAR，整体当声明
        return content, ''

    decl = '\n'.join(lines[:last_end_var + 1])
    impl = '\n'.join(lines[last_end_var + 1:])
    return decl, impl


def extract_object_name(content, file_type):
    """从内容中提取对象名称"""
    if file_type == 'pou':
        m = re.match(r'(?:FUNCTION_BLOCK|PROGRAM|FUNCTION)\s+(\S+)', content.strip(), re.IGNORECASE)
        if m:
            return m.group(1)
    elif file_type == 'dut':
        m = re.search(r'TYPE\s+(\S+)\s*:', content, re.IGNORECASE)
        if m:
            return m.group(1)
    return None


def find_object_by_name(parent, target_name, recursive=True):
    """在工程树中按名称查找对象"""
    try:
        if hasattr(parent, 'get_children'):
            children = parent.get_children(recursive=recursive)
            for child in children:
                try:
                    if hasattr(child, 'get_name'):
                        name = child.get_name()
                    else:
                        name = str(child)
                    if name == target_name:
                        return child
                except:
                    pass
    except:
        pass
    return None


def find_object_by_path(proj, path_or_parts):
    """
    根据导出时的相对路径，在工程树中定位对象
    path_or_parts: 字符串路径或路径部分列表
    """
    if isinstance(path_or_parts, list):
        parts = path_or_parts
    else:
        parts = path_or_parts.split('/')
    current = proj
    for part in parts:
        found = None
        if hasattr(current, 'get_children'):
            for child in current.get_children(recursive=False):
                try:
                    if hasattr(child, 'get_name'):
                        name = child.get_name()
                    else:
                        name = str(child)
                    if name == part:
                        found = child
                        break
                except:
                    pass
        if found is None:
            return None
        current = found
    return current


def set_text_content(doc, new_text):
    """
    设置 ScriptTextDocument 的内容
    InProShop V1.9 的 text 属性是只读的，需要用 replace 方法
    """
    # 方法1: 直接赋值 (CODESYS 3.5.16+)
    try:
        doc.text = new_text
        return True
    except:
        pass
    
    # 方法2: 用 replace 方法替换全部内容 (InProShop V1.9)
    try:
        old_text = doc.text or ''
        doc.replace(0, len(old_text), new_text)
        return True
    except:
        pass
    
    # 方法3: 清空后插入
    try:
        old_text = doc.text or ''
        if old_text:
            doc.remove(0, len(old_text))
        doc.insert(0, new_text)
        return True
    except:
        pass
    
    return False


def update_object_text(obj, file_type, content, log_lines, file_path):
    """更新对象的文本内容"""
    try:
        if hasattr(obj, 'get_name'):
            name = obj.get_name()
        else:
            name = str(obj)

        if file_type == 'pou':
            decl, impl = split_pou_decl_impl(content)
            updated = False

            # 更新声明
            if decl.strip():
                if hasattr(obj, 'textual_declaration'):
                    if set_text_content(obj.textual_declaration, decl):
                        updated = True
                elif hasattr(obj, 'set_textual_declaration'):
                    obj.set_textual_declaration(decl)
                    updated = True

            # 更新实现
            if impl.strip():
                if hasattr(obj, 'textual_implementation'):
                    if set_text_content(obj.textual_implementation, impl):
                        updated = True
                elif hasattr(obj, 'set_textual_implementation'):
                    obj.set_textual_implementation(impl)
                    updated = True

            if updated:
                log_lines.append("[OK] Updated POU: %s" % name)
            else:
                log_lines.append("[SKIP] POU %s: no writable text property" % name)

        elif file_type == 'gvl':
            if hasattr(obj, 'textual_declaration'):
                if set_text_content(obj.textual_declaration, content):
                    log_lines.append("[OK] Updated GVL: %s" % name)
                else:
                    log_lines.append("[SKIP] GVL %s: cannot write text" % name)
            elif hasattr(obj, 'set_textual_declaration'):
                obj.set_textual_declaration(content)
                log_lines.append("[OK] Updated GVL: %s" % name)
            else:
                log_lines.append("[SKIP] GVL %s: no writable text property" % name)

        elif file_type == 'dut':
            if hasattr(obj, 'textual_declaration'):
                if set_text_content(obj.textual_declaration, content):
                    log_lines.append("[OK] Updated DUT: %s" % name)
                else:
                    log_lines.append("[SKIP] DUT %s: cannot write text" % name)
            elif hasattr(obj, 'set_textual_declaration'):
                obj.set_textual_declaration(content)
                log_lines.append("[OK] Updated DUT: %s" % name)
            else:
                log_lines.append("[SKIP] DUT %s: no writable text property" % name)

        elif file_type == 'action':
            if hasattr(obj, 'textual_implementation'):
                if set_text_content(obj.textual_implementation, content):
                    log_lines.append("[OK] Updated Action: %s" % name)
                else:
                    log_lines.append("[SKIP] Action %s: cannot write text" % name)
            elif hasattr(obj, 'set_textual_implementation'):
                obj.set_textual_implementation(content)
                log_lines.append("[OK] Updated Action: %s" % name)
            else:
                log_lines.append("[SKIP] Action %s: no writable text property" % name)

    except Exception as e:
        log_lines.append("[ERR] Failed to update %s: %s" % (file_path, str(e)))


# ============================================================================
# Graph 调用行管理
# ============================================================================

def _ensure_action_call_in_graph(graph_obj, action_name, log_lines):
    """
    在 graph_obj（OPXX_Graph POU）的 textual_implementation 中确保存在
    `action_name();` 这一行调用。
    - 已存在：跳过（不重复添加）
    - 不存在：追加到实现代码末尾（保留原有内容）
    """
    # 只处理名称以 _Graph 结尾的 POU，避免误操作其它 POU
    try:
        parent_name = graph_obj.get_name() if hasattr(graph_obj, 'get_name') else ''
        if not parent_name.endswith('_Graph'):
            return
    except:
        return

    call_line = '%s();' % action_name

    try:
        if not hasattr(graph_obj, 'textual_implementation'):
            log_lines.append("[WARN] %s has no textual_implementation, skip adding call" % parent_name)
            return

        doc = graph_obj.textual_implementation
        try:
            current_text = doc.text or ''
        except:
            current_text = ''

        # 检查是否已存在（忽略大小写和行尾空白）
        call_lower = call_line.lower()
        for existing_line in current_text.splitlines():
            if existing_line.strip().lower() == call_lower:
                log_lines.append("[INFO] Action call already exists in %s: %s" % (parent_name, call_line))
                return

        # 不存在：在末尾追加（保留原始内容，仅在最后加一行）
        # 确保末尾有换行，再追加调用行
        sep = '\r\n' if '\r\n' in current_text else '\n'
        new_text = current_text.rstrip() + sep + call_line + sep
        if set_text_content(doc, new_text):
            log_lines.append("[OK] Added action call in %s: %s" % (parent_name, call_line))
        else:
            log_lines.append("[WARN] Cannot write to %s textual_implementation" % parent_name)
    except:
        import traceback
        log_lines.append("[WARN] _ensure_action_call_in_graph failed for %s: %s" % (
            action_name, traceback.format_exc().splitlines()[-1]))


# ============================================================================
# 创建新对象
# ============================================================================

def get_pou_subtype(content):
    """
    判断 POU 子类型
    返回: 'program', 'function_block', 'function'
    """
    upper = content.strip().upper()
    if upper.startswith('PROGRAM '):
        return 'program'
    elif upper.startswith('FUNCTION_BLOCK '):
        return 'function_block'
    elif upper.startswith('FUNCTION '):
        return 'function'
    return 'function_block'


def find_or_create_folder(parent, folder_name, log_lines):
    """在 parent 下查找文件夹，不存在则创建"""
    # 先查找
    if hasattr(parent, 'get_children'):
        for child in parent.get_children(recursive=False):
            try:
                if hasattr(child, 'get_name'):
                    name = child.get_name()
                else:
                    name = str(child)
                if name == folder_name:
                    return child
            except:
                pass

    # 创建文件夹
    try:
        if hasattr(parent, 'create_folder'):
            folder = parent.create_folder(folder_name)
            log_lines.append("[NEW] Created folder: %s" % folder_name)
            return folder
    except Exception as e:
        log_lines.append("[ERR] Cannot create folder %s: %s" % (folder_name, str(e)))
    return None


def find_child_by_name(parent, name):
    """在 parent 的直接子节点中查找指定名称的节点（含递归=False 的所有节点类型）"""
    if not hasattr(parent, 'get_children'):
        return None
    try:
        for child in parent.get_children(recursive=False):
            try:
                child_name = child.get_name() if hasattr(child, 'get_name') else str(child)
                if child_name == name:
                    return child
            except:
                pass
    except:
        pass
    return None


def navigate_to_parent(proj, tree_parts, log_lines):
    """
    沿 tree_parts 路径逐级向下，定位父节点。
    - 已有节点（含 POU）直接进入。
    - Device / Plc Logic / Application 必须存在。
    - 其他不存在的中间节点：先尝试创建文件夹，再尝试全局按名称查找（处理 POU 作为容器的情况）。
    """
    current = proj
    for part in tree_parts:
        found = find_child_by_name(current, part)
        if found is None:
            # Device / Plc Logic / Application 必须已经存在
            if part in ('Device', 'Plc Logic', 'Application'):
                log_lines.append("[ERR] Required node not found: %s" % part)
                return None
            # 尝试在整个工程树中按名称查找（可能是 POU/FB 对象，而非文件夹）
            found = find_object_by_name(proj, part, recursive=True)
            if found:
                log_lines.append("[INFO] Found '%s' by global name search (may be a POU)" % part)
            else:
                # 尝试创建文件夹
                found = find_or_create_folder(current, part, log_lines)
                if found is None:
                    return None
        current = found
    return current


def log_available_methods(obj, log_lines, label=""):
    """记录对象可用的 create 方法，用于诊断"""
    methods = [m for m in dir(obj) if 'create' in m.lower() and callable(getattr(obj, m, None))]
    if methods:
        log_lines.append("[DBG] %s available create methods: %s" % (label, ', '.join(methods)))
    else:
        log_lines.append("[DBG] %s has no create* methods" % label)


def _write_content_to_obj(new_obj, file_type, content, log_lines, obj_name):
    """将内容写入新创建的对象"""
    if file_type == 'pou':
        decl, impl = split_pou_decl_impl(content)
        if decl.strip() and hasattr(new_obj, 'textual_declaration'):
            set_text_content(new_obj.textual_declaration, decl)
        if impl.strip() and hasattr(new_obj, 'textual_implementation'):
            set_text_content(new_obj.textual_implementation, impl)
    elif file_type in ('gvl', 'dut'):
        if hasattr(new_obj, 'textual_declaration'):
            set_text_content(new_obj.textual_declaration, content)
    elif file_type == 'action':
        if hasattr(new_obj, 'textual_implementation'):
            set_text_content(new_obj.textual_implementation, content)
        elif hasattr(new_obj, 'textual_declaration'):
            set_text_content(new_obj.textual_declaration, content)


def create_new_object(parent, obj_name, file_type, content, log_lines):
    """在 parent 下创建新的 POU / GVL / DUT / Action 并写入内容"""
    try:
        new_obj = None

        if file_type == 'pou':
            pou_subtype = get_pou_subtype(content)
            # pou_type: 0=PROGRAM, 1=FUNCTION_BLOCK, 2=FUNCTION
            # InProShop V1.9 的 create_pou(name, pou_type) 不接受 int 语言参数；
            # 先不带语言参数尝试，失败再带 int，以兼容不同版本
            type_map = {'program': 0, 'function_block': 1, 'function': 2}
            pou_type_id = type_map.get(pou_subtype, 1)

            for _fn_name, _args in [
                ('create_pou', (obj_name, pou_type_id)),
                ('create_pou', (obj_name, pou_type_id, 1)),
                ('create',     (obj_name, pou_type_id)),
                ('create',     (obj_name, 'pou')),
            ]:
                try:
                    _fn = getattr(parent, _fn_name, None)
                    if _fn is None:
                        continue
                    new_obj = _fn(*_args)
                    if new_obj:
                        break
                except:
                    pass

            if new_obj:
                _write_content_to_obj(new_obj, file_type, content, log_lines, obj_name)
                log_lines.append("[NEW] Created POU (%s): %s" % (pou_subtype, obj_name))
                return True

        elif file_type == 'gvl':
            for _fn_name, _args in [
                ('create_gvl', (obj_name,)),
                ('create',     (obj_name, 'gvl')),
                ('create_pou', (obj_name, 0)),   # fallback: PROGRAM
            ]:
                try:
                    _fn = getattr(parent, _fn_name, None)
                    if _fn is None:
                        continue
                    new_obj = _fn(*_args)
                    if new_obj:
                        break
                except:
                    pass

            if new_obj:
                _write_content_to_obj(new_obj, file_type, content, log_lines, obj_name)
                log_lines.append("[NEW] Created GVL: %s" % obj_name)
                return True

        elif file_type == 'dut':
            for _fn_name, _args in [
                ('create_dut',  (obj_name,)),
                ('create',      (obj_name, 'dut')),
                ('create',      (obj_name, 'struct')),
            ]:
                try:
                    _fn = getattr(parent, _fn_name, None)
                    if _fn is None:
                        continue
                    new_obj = _fn(*_args)
                    if new_obj:
                        break
                except:
                    pass

            if new_obj:
                _write_content_to_obj(new_obj, file_type, content, log_lines, obj_name)
                log_lines.append("[NEW] Created DUT: %s" % obj_name)
                return True

        elif file_type == 'action':
            # Action 必须挂在 POU 下；parent 应是 PROGRAM/FB POU 对象。
            # InProShop V1.9 的 create_action 不接受 int 语言参数（期望 Nullable[Guid]），
            # 先用无参版本，再逐步降级。bare except 可捕获 CLR 异常。
            for _fn_name, _args in [
                ('create_action', (obj_name,)),          # 不传语言参数（最兼容）
                ('create_action', (obj_name, None)),     # 显式 None
                ('create',        (obj_name, 'action')),
                ('create',        (obj_name,)),
            ]:
                try:
                    _fn = getattr(parent, _fn_name, None)
                    if _fn is None:
                        continue
                    new_obj = _fn(*_args)
                    if new_obj:
                        break
                except:
                    pass

            if new_obj:
                _write_content_to_obj(new_obj, file_type, content, log_lines, obj_name)
                log_lines.append("[NEW] Created Action: %s" % obj_name)
                # 新建 Action 后，在父 _Graph POU 的实现中补充调用行
                _ensure_action_call_in_graph(parent, obj_name, log_lines)
                return True

        if new_obj is None:
            log_available_methods(parent, log_lines, "parent of %s" % obj_name)
            log_lines.append("[ERR] Cannot create %s (type=%s): all creation attempts failed" % (obj_name, file_type))
            return False

    except:
        import traceback
        log_lines.append("[ERR] Failed to create %s: %s" % (obj_name, traceback.format_exc().splitlines()[-1]))
        return False

    return False


# ============================================================================
# 路径解析
# ============================================================================

def parse_export_path(file_path, export_dir):
    """
    解析导出文件路径，提取工程树路径和对象名
    返回: (tree_path_parts, object_name, is_action)

    新版导出路径格式: 0.Struct/Str_Graph.st
    旧版导出路径格式: Project(xxx)/Device/.../Application/0.Struct/Str_Graph.txt
    两种都兼容
    """
    rel = os.path.relpath(file_path, export_dir)
    rel = rel.replace('\\', '/')

    # 跳过 _actions 子目录里的文件
    if '/_actions/' in rel:
        return None, None, True

    # 去掉文件扩展名
    base = os.path.splitext(os.path.basename(rel))[0]
    dir_part = os.path.dirname(rel)

    # 兼容旧版：如果路径包含 Application/，截取其后面的部分
    if '/Application/' in dir_part:
        dir_part = dir_part.split('/Application/', 1)[1]
    # 兼容旧版：如果路径以 Project( 开头，去掉第一层
    elif dir_part.startswith('Project('):
        idx = dir_part.find('/')
        if idx >= 0:
            dir_part = dir_part[idx + 1:]
        else:
            dir_part = ''

    if dir_part:
        parts = dir_part.split('/')
    else:
        parts = []

    # 构建完整工程树路径: Device/Plc Logic/Application + parts
    tree_parts = ['Device', 'Plc Logic', 'Application'] + parts

    return tree_parts, base, False


# ============================================================================
# 主函数
# ============================================================================

def main():
    log_lines = []
    log_lines.append("=" * 60)
    log_lines.append("InProShop Project Import Script")
    log_lines.append("Start Time: %s" % datetime.datetime.now().isoformat())
    log_lines.append("=" * 60)

    export_dir = ''

    try:
        proj = open_project_if_needed(log_lines)
        if not proj:
            log_lines.append("[ERR] No project available.")
            print('\n'.join(log_lines))
            return

        # 确定导出目录
        if hasattr(proj, 'path') and proj.path:
            proj_dir = os.path.dirname(proj.path)
            proj_name = os.path.splitext(os.path.basename(proj.path))[0]
            export_dir = os.path.join(proj_dir, proj_name + '_exported')
            project_path_norm = os.path.normcase(os.path.normpath(proj.path))
            model_marker = os.path.normcase(os.path.join("ProjectFile", "Model")) + os.sep
            if model_marker in project_path_norm or proj_name.lower() == "model":
                log_lines.append("[ERR] Refuse to import into Model project (reference only). Open ProjectFile/Project/Project.project first.")
                print('\n'.join(log_lines))
                return
        else:
            export_dir = os.path.join(os.path.expanduser('~'), 'InProShop_Export')

        if not os.path.exists(export_dir):
            log_lines.append("[ERR] Export directory not found: %s" % export_dir)
            print('\n'.join(log_lines))
            return

        log_lines.append("[INFO] Import from: %s" % export_dir)

        # 确认
        if CONFIRM_BEFORE_IMPORT:
            try:
                result = system.ui.prompt(
                    "Import modified files from:\n%s\n\nMake sure you have backed up the project!\n\nContinue?" % export_dir,
                    0, "OK", "Cancel")
                if result != 0:
                    log_lines.append("[INFO] Import cancelled by user.")
                    print('\n'.join(log_lines))
                    return
            except Exception as e:
                # 弹窗 API 不兼容则跳过确认，直接执行
                log_lines.append("[WARN] Confirm dialog failed (%s), proceeding anyway" % str(e))

        # 收集要导入的文件
        import_files = []
        for root, dirs, files in os.walk(export_dir):
            for fname in files:
                # 跳过元文件
                if fname in SKIP_FILES:
                    continue
                # 跳过 _actions 目录 (和主文件重复)
                if '_actions' in root:
                    continue
                # 只处理 .txt 和 .st
                ext = os.path.splitext(fname)[1].lower()
                if ext not in ('.txt', '.st'):
                    continue
                # 目录过滤
                if FILTER_DIRS:
                    rel = os.path.relpath(root, export_dir)
                    match = False
                    for d in FILTER_DIRS:
                        if d in rel:
                            match = True
                            break
                    if not match:
                        continue

                import_files.append(os.path.join(root, fname))

        log_lines.append("[INFO] Found %d files to import" % len(import_files))
        log_lines.append("[INFO] Create new objects: %s" % ('YES' if ALLOW_CREATE_NEW else 'NO'))
        log_lines.append("")

        # 逐文件处理
        ok_count = 0
        new_count = 0
        skip_count = 0
        err_count = 0

        for file_path in import_files:
            try:
                content = read_text_file(file_path)
                if not content or not content.strip():
                    skip_count += 1
                    continue

                # 判断文件类型
                fname = os.path.basename(file_path)
                file_type = detect_file_type(content, fname)

                # 解析路径
                tree_parts, obj_name, is_action_dup = parse_export_path(file_path, export_dir)
                if is_action_dup:
                    skip_count += 1
                    continue
                if tree_parts is None or obj_name is None:
                    log_lines.append("[SKIP] Cannot parse path: %s" % file_path)
                    skip_count += 1
                    continue

                # 在工程树中定位对象
                tree_path = '/'.join(tree_parts) + '/' + obj_name
                obj = find_object_by_path(proj, tree_parts + [obj_name])

                if obj is None:
                    # 备选：按名称全局搜索 (可能命中同名但不同位置的对象)
                    obj = find_object_by_name(proj, obj_name, recursive=True)
                    if obj:
                        log_lines.append("[WARN] Path not found, matched by name: %s" % obj_name)

                if obj is None:
                    if ALLOW_CREATE_NEW:
                        # 尝试创建新对象
                        parent = navigate_to_parent(proj, tree_parts, log_lines)
                        if parent:
                            created = create_new_object(parent, obj_name, file_type, content, log_lines)
                            if created:
                                new_count += 1
                            else:
                                err_count += 1
                        else:
                            log_lines.append("[ERR] Cannot find/create parent path: %s" % '/'.join(tree_parts))
                            err_count += 1
                    else:
                        log_lines.append("[SKIP] Object not found (create disabled): %s" % tree_path)
                        skip_count += 1
                    continue

                # 更新对象
                update_object_text(obj, file_type, content, log_lines, file_path)
                ok_count += 1

                # Action 更新时，也检查父 _Graph POU 中是否有调用行（防止调用行缺失）
                if file_type == 'action' and len(tree_parts) > 0:
                    _parent_name = tree_parts[-1] if tree_parts else ''
                    if _parent_name.endswith('_Graph'):
                        _graph_obj = find_object_by_path(proj, tree_parts)
                        if _graph_obj:
                            _ensure_action_call_in_graph(_graph_obj, obj_name, log_lines)

            except Exception as e:
                log_lines.append("[ERR] %s: %s" % (file_path, str(e)))
                err_count += 1

        # 汇总
        log_lines.append("")
        log_lines.append("=== Summary ===")
        log_lines.append("Updated: %d" % ok_count)
        log_lines.append("Created: %d" % new_count)
        log_lines.append("Skipped: %d" % skip_count)
        log_lines.append("Errors: %d" % err_count)

        # 自动化导入场景下，导入完成后直接保存 .project。
        try:
            if hasattr(proj, 'save'):
                proj.save()
                log_lines.append("[OK] Project saved.")
        except Exception as e:
            log_lines.append("[WARN] Project save failed: %s" % str(e))

    except Exception as e:
        log_lines.append("[ERR] Main: %s" % str(e))
        import traceback
        log_lines.append(traceback.format_exc())

    log_lines.append("")
    log_lines.append("=" * 60)
    log_lines.append("End Time: %s" % datetime.datetime.now().isoformat())
    log_lines.append("=" * 60)

    # 写入日志
    try:
        if export_dir:
            log_file = os.path.join(export_dir, '_import_log.txt')
            write_log(log_file, log_lines)
    except:
        pass

    print('\n'.join(log_lines))
    if export_dir:
        print("\nImport completed. Check: %s" % os.path.join(export_dir, '_import_log.txt'))


if __name__ == '__main__':
    main()
else:
    main()
