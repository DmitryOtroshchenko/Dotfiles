#!/usr/bin/env python
# encoding: utf-8

from __future__ import division, unicode_literals, print_function

import numpy
import sys
import timeit

print('''
Usage:
    OMP_NUM_THREADS=... ./test_numpy.py
''')

try:
    import numpy.core._dotblas
    print('FAST BLAS')
except ImportError:
    print('slow blas')

print('Version: ', numpy.__version__)
print('Max INT: ', sys.maxint)
print()

setup = '''
import numpy
x = numpy.random.random((1500, 1500))
'''
count = 5

t = timeit.Timer('numpy.dot(x, x.T)', setup=setup)
print('Dot: ', t.timeit(count) / count, ' sec')
