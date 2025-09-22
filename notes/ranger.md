# Ranger File Manager Reference

Clean, fast ranger configuration focused on speed and stability.

## View Configuration

**Layout:**
- Miller columns (1:3:4 ratio)
- Hidden files filtered by default
- Preview enabled for files and directories
- Image preview via w3m

**Display Features:**
- File size in main column and status bar
- Free space in status bar
- Progress bar in status bar
- Tags in all columns
- Borders enabled
- Mouse support enabled

## Key Features

**File Management:**
- Automatic file counting
- Multiple file delete confirmation
- Open all images together
- Console history saved

**Preview System:**
- Files and directories previewed
- Images displayed (w3m method)
- Collapsible preview
- Custom preview scripts enabled

**Performance:**
- VCS awareness disabled for speed
- Git backend disabled
- Hidden file regex filtering
- Status bar at bottom

## Hidden Files Filter

Files matching these patterns are hidden by default:
- Dotfiles (`^\.`)
- Python compiled files (`.pyc`, `.pyo`)
- Backup files (`.bak`)
- Swap files (`.swp`)
- Lost+found directories
- Cache directories

## File Types

**Custom file associations** defined in `rifle.conf`
**Custom commands** available in `commands.py`
**Preview behavior** controlled by `scope.sh`

## Default Keybinds

Ranger uses vim-like navigation:
- `h/j/k/l` - Navigate (left/down/up/right)
- `q` - Quit
- `r` - Open with application
- `yy` - Copy (yank)
- `pp` - Paste
- `dd` - Cut
- `cw` - Rename
- `zh` - Toggle hidden files
- `S` - Open shell in current directory

## Configuration Files

- `rc.conf` - Main configuration
- `rifle.conf` - File associations
- `commands.py` - Custom commands
- `scope.sh` - Preview script