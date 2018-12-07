from __future__ import absolute_import, division, print_function

import os.path
import subprocess

from ranger.api.commands import Command


class fzf_select(Command):
    """:fzf_select [-a | -d | -f]

    Find a file using fzf.
    """

    FLAGS = {'-a', '-d', '-f'}

    def execute(self):
        if len(self.args) == 1:
            mode = 'a'
        elif len(self.args) == 2:
            assert self.args[1] in self.FLAGS, 'Invalid fzf_select flag.'
            mode = self.args[1][1]
        else:
            assert len(self.args) <= 2, 'Invalid fzf_select call.'

        command = ' | '.join([
            self._format_find_call(mode),
            "sed 1d",
            "cut -b3-",
            "fzf +m",
        ])
        fzf = self.fm.execute_command(
            command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
        else:
            self.fm.notify("FZF call failed", bad=True)

    @staticmethod
    def _format_find_call(mode):
        type_selector_from_mode = {
            'a': '',
            'd': '-type d',
            'f': '-not \( -type d \)',
        }
        return (
            "find -L . "
            "\( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) "
            "-prune -o {} -print "
            "2> /dev/null"
        ).format(type_selector_from_mode[mode])
