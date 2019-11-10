import os.path
import sys
import time

import iterfzf

from ranger.api.commands import Command


def iter_pokemon(sleep=0.01):
    filename = os.path.join(os.path.dirname(__file__), 'pokemon.txt')
    with open(filename) as f:
        for l in f:
            yield l.strip()
            time.sleep(sleep)


class fzf_select(Command):
    ''':fzf_select [-a | -d | -f]

    Find a file using fzf.
    '''

    FLAGS = {'-a', '-d', '-f'}

    def execute(self):
        self.fm.notify(sys.executable, bad=False)
        result = iterfzf.iterfzf(iter_pokemon(), multi=False)
        for item in result:
            self.fm.notify(item, bad=False)

        self.fm.ui.redraw_window()
