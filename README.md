## How to install
Run the install script for auto handling the installation/linking or manually handle the installation/linking. Directories are `stow`able

### About the script
- Loops over the directories and prompts for installation and/or linking (uses `stow` tool).
- Prompt for a system update first (arch/debian based distros supported only).
- Does not try to install anything, default answer when prompting for installation is No.
- Python libraries are installed with `pip install --user` to avoid messing system files.
- Directories that do not need any installation, will only be linked.
- Follows the [XDG Base Directory Specification](https://wiki.archlinux.org/index.php/XDG_Base_Directory).


### Terminal
- Emulator: [Alacritty](https://github.com/alacritty/alacritty)
- Shell: bash
- Multiplexer: [tmux](https://tmux.github.io/)
- Text Editor: [Neovim](https://neovim.io/)

### Searching files/text
- Command-line fuzzy finder: [fzf](https://github.com/junegunn/fzf)
- Text search: [ripgrep](https://github.com/BurntSushi/ripgrep)
- File search: [fd](https://github.com/sharkdp/fd)
- Directory search: [bfs](https://github.com/tavianator/bfs)
- Jump to directories: [fasd](https://github.com/clvv/fasd)

### Version Control
- Better git diffs: [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- Text mode interface for git: [tig](https://github.com/jonas/tig)

### System stats/monitoring
- Task Manager: [bashtop](https://github.com/aristocratos/bashtop) or [htop](http://hisham.hm/htop/)
- System Monitor: [glances](https://github.com/nicolargo/glances)
- Disk usage analyzer: [ncdu](https://dev.yorhel.nl/ncdu)

### Generic
- Launcher: [j4-dmenu](https://github.com/enkore/j4-dmenu-desktop)
- Notifications: [dunst](https://github.com/dunst-project/dunst)
- File Manager: [fff](https://github.com/dylanaraps/fff) or [vifm](https://github.com/vifm/vifm)
- List files/dirs in a tree-like format: tree
- System lock: xautolock
- Screen color temperature: [Redshift](https://github.com/jonls/redshift)
- Command line HTTP client: curl or [HTTPie](https://github.com/jkbrzt/httpie)

### Database
- Postgres cli: [pgcli](https://www.pgcli.com/)
- MySQL cli: [mycli](http://www.mycli.net/)
- MongoDB shell enhancements: [mongo-hacker](https://github.com/TylerBrock/mongo-hacker)
- SQL graphical interface:
    - SQLite: [sqlitebrowser](https://sqlitebrowser.org/)
    - PostgreSQL/MySQL/Microsoft SQL Server/Cassandra/SQLite: [sqlelectron](https://sqlectron.github.io/)

### Chat/Mail
- Chat: [Weechat](https://weechat.org/)
- Email: [neomutt](https://neomutt.org/)

### Media:
- Image viewer: [imv](https://github.com/eXeC64/imv)
- Screenshot tool: scrot
- PDF viewer: [zathura](https://pwmt.org/projects/zathura/) 
- Video player: [mpv](https://mpv.io/)
- Audio: mpd+mpc+ncmpcpp
- Youtube player/downloader: [mps-youtube](https://github.com/mps-youtube/mps-youtube)

### Other
- Usb mount: [udiskie](https://github.com/coldfix/udiskie)
- Colorized cat: [ccat](https://github.com/jingweno/ccat)
- Translator: [translate-shell](https://github.com/soimort/translate-shell)
- Password manager: [keepassxc](https://keepassxc.org/)
- Notes/Todo: [standard notes](https://standardnotes.org/)
- Json - cli json processor: [jq](https://stedolan.github.io/jq/)
