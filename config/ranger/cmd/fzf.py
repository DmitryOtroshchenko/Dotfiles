from __future__ import absolute_import, division, print_function

import os.path
import subprocess

from ranger.api.commands import Command

import iterfzf


def run_and_merge_stdout(command):
    '''From http://blog.kagesenshi.org/2008/02/teeing-python-subprocesspopen-output.html
    https://www.saltycrane.com/blog/2009/10/how-capture-stdout-in-real-time-python/
    '''
    p = subprocess.Popen(
        command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    line = '<non-empty>'
    while line or p.poll() is None:
        line = p.stdout.readline()
        yield line.decode('utf8').strip()


class fzf_select(Command):
    ''':fzf_select [-a | -d | -f]

    Find a file using fzf.
    '''

    FLAGS = {'-a', '-d', '-f'}

    def execute(self):
        import sys
        self.fm.notify(sys.executable, bad=False)
        return
        assert 2 <= len(self.args) <= 3, 'Invalid fzf_select call.'
        if len(self.args) == 2:
            root = self.args[1]
            mode = 'a'
        elif len(self.args) == 3:
            root = self.args[1]
            assert self.args[2] in self.FLAGS, 'Invalid fzf_select flag.'
            mode = self.args[2]
        else:
            assert False

        chosen = self._fuzzy_choose_one(root, mode)
        if chosen:
            fzf_file = os.path.abspath(chosen)
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
        else:
            self.fm.notify('FZF call failed', bad=True)

    def _fuzzy_choose_one(self, root, mode):
        # self.fm.notify(f'{root} : {mode}', bad=False)
        res = iterfzf.iterfzf(
            run_and_merge_stdout(self._format_find_call(root, mode))
        )
        # self.fm.notify(f'Selected = {res}', bad=False)
        return res

    @staticmethod
    def _format_find_call(root, mode):
        type_selector_from_mode = {
            '-a': '',
            '-d': '-type d',
            '-f': '-not \( -type d \)',
        }
        return (
            "find -L {} "
            "\( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) "
            "-prune -o {} -print "
            "2> /dev/null"
        ).format(root, type_selector_from_mode[mode])
