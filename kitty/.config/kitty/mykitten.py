import os


def main(args):
    pass


def to_neighbor_direction(direction):
    return dict(up='top', down='bottom', left='left', right='right')[direction]


def move_to_window(direction, boss):
    """Focus to the kitty window in the given direction."""
    current_window_id = boss.active_window.id
    n_direction = to_neighbor_direction(direction)
    boss.active_tab.neighboring_window(n_direction)
    new_window_id = boss.active_window.id
    if current_window_id == new_window_id:
        os.system('i3-msg focus ' + direction)


def is_vim_running(boss):
    """Return if vim is running and is the foreground process."""
    foreground_process = boss.active_window.child.foreground_processes[0]
    return foreground_process['cmdline'][0] in ('nvim', 'vim')


def handle_result(args, answer, target_window_id, boss):
    direction = dict(h='left', j='down', k='up', l='right').get(args[1])
    if direction:  # remote control from vim
        move_to_window(direction, boss)
    elif is_vim_running(boss):
        w = boss.window_id_map.get(target_window_id)
        vim_key = dict(left='h', right='l', up='k', down='j')[args[1]]
        w.paste('\x1b' + vim_key)
    else:
        move_to_window(args[1], boss)


handle_result.no_ui = True
