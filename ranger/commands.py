# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()

class fzf_select(Command):
    """
    :fzf_select
    Find a file or directory using fzf.
    """
    def execute(self):
        import subprocess
        import os.path
        from ranger.ext.get_executables import get_executables
        
        if 'fzf' not in get_executables():
            self.fm.notify('Could not find fzf in PATH', bad=True)
            return
        
        env = os.environ.copy()
        env['FZF_DEFAULT_OPTS'] = '--height=40% --layout=reverse --border'
        
        # Use fd if available, else find
        if 'fd' in get_executables():
            fzf = self.fm.execute_command('fd . | fzf', env=env,
                                        universal_newlines=True,
                                        stdout=subprocess.PIPE)
        else:
            fzf = self.fm.execute_command('find . | fzf', env=env,
                                        universal_newlines=True,
                                        stdout=subprocess.PIPE)
        
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            if os.path.isdir(selected):
                self.fm.cd(selected)
            else:
                self.fm.select_file(selected)
                
class fzf_locate(Command):
    """
    :fzf_locate
    Find a file in the whole system using locate and fzf.
    """
    def execute(self):
        import subprocess
        import os.path
        from ranger.ext.get_executables import get_executables
        
        if 'fzf' not in get_executables():
            self.fm.notify('Could not find fzf in PATH', bad=True)
            return
            
        if 'locate' not in get_executables():
            self.fm.notify('Could not find locate in PATH', bad=True)
            return
        
        env = os.environ.copy()
        env['FZF_DEFAULT_OPTS'] = '--height=40% --layout=reverse --border'
        
        fzf = self.fm.execute_command('locate / | fzf', env=env,
                                    universal_newlines=True,
                                    stdout=subprocess.PIPE)
        
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = stdout.strip()
            if os.path.exists(selected):
                if os.path.isdir(selected):
                    self.fm.cd(selected)
                else:
                    self.fm.select_file(selected)

class fzf_grep(Command):
    """
    :fzf_grep [<search_term>]
    Search file contents using ripgrep and open with fzf.
    """
    def execute(self):
        import subprocess
        import os
        from ranger.ext.get_executables import get_executables
        
        if 'rg' not in get_executables():
            self.fm.notify('Could not find ripgrep in PATH', bad=True)
            return
        if 'fzf' not in get_executables():
            self.fm.notify('Could not find fzf in PATH', bad=True)
            return
            
        search_term = self.rest(1)
        if not search_term:
            self.fm.notify('Usage: fzf_grep <search_term>', bad=True)
            return
        
        env = os.environ.copy()
        env['FZF_DEFAULT_OPTS'] = '--height=40% --layout=reverse --border'
        
        command = f"rg --files-with-matches --no-messages '{search_term}' | fzf"
        fzf = self.fm.execute_command(command, env=env,
                                    universal_newlines=True,
                                    stdout=subprocess.PIPE)
        
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            self.fm.select_file(selected)

class fzf_cd(Command):
    """
    :fzf_cd
    Change to a subdirectory using fzf.
    """
    def execute(self):
        import subprocess
        import os.path
        from ranger.ext.get_executables import get_executables
        
        if 'fzf' not in get_executables():
            self.fm.notify('Could not find fzf in PATH', bad=True)
            return
        
        env = os.environ.copy()
        env['FZF_DEFAULT_OPTS'] = '--height=40% --layout=reverse --border'
        
        # Find only directories
        if 'fd' in get_executables():
            command = 'fd --type d . | fzf'
        else:
            command = 'find . -type d | fzf'
        
        fzf = self.fm.execute_command(command, env=env,
                                    universal_newlines=True,
                                    stdout=subprocess.PIPE)
        
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            self.fm.cd(selected)

class mkcd(Command):
    """
    :mkcd <dirname>
    Create a directory and enter it.
    """
    def execute(self):
        from os.path import join, expanduser, lexists
        from os import makedirs
        
        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            makedirs(dirname)
            self.fm.cd(dirname)
        else:
            self.fm.notify("Directory already exists!", bad=True)

class compress(Command):
    """
    :compress [<filename>]
    Compress selected files to archive.
    """
    def execute(self):
        import os
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()
        
        if not marked_files:
            return
        
        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()
        
        original_path = cwd.path
        parts = self.line.split()
        if len(parts) > 1:
            archive_name = parts[1]
        else:
            archive_name = os.path.basename(marked_files[0]) + '.tar.gz'
        
        # Create archive command
        files_list = ' '.join([f.relative_path for f in marked_files])
        self.fm.execute_console(f'shell tar czf {archive_name} {files_list}')
        self.fm.reload_cwd()

class extract(Command):
    """
    :extract
    Extract selected archives.
    """
    def execute(self):
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()
        
        if not marked_files:
            return
        
        for f in marked_files:
            if f.is_file:
                self.fm.execute_console(f'shell atool -x {f.relative_path}')
        
        self.fm.reload_cwd()
