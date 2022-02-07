import unittest
import numpy as np

import sys, os
sys.path.append('src//ml//speech_rec//LAS//utils')

from input_functions import OneHotEncode, ZeroPadding


class TestInputFunctions(unittest.TestCase):

    def test_ZeroPadding(self):
        padding = 6
        input = np.array([[ 0,  1,  2,  3,  4],[ 5,  6,  7,  8,  9]])
        output = ZeroPadding(input, padding)
        expected_output = np.array([[[0.0,1.0,2.0,3.0,4.0],[0.0,1.0,2.0,3.0,4.0],[0.0,1.0,2.0,3.0,4.0],[0.0,1.0,2.0,3.0,4.0],[0.0,1.0,2.0,3.0,4.0],[0.0,0.0,0.0,0.0,0.0]],[[5.0,6.0,7.0,8.0,9.0],[5.0,6.0,7.0,8.0,9.0],[5.0,6.0,7.0,8.0,9.0],[5.0,6.0,7.0,8.0,9.0],[5.0,6.0,7.0,8.0,9.0],[0.0,0.0,0.0,0.0,0.0]]])
        np.testing.assert_array_equal(output, expected_output)
    
    def test_OneHotEncode(self): 
        input = np.array([[0], [1]])
        output = OneHotEncode(input, 2, 2)
        expected_output = np.array([[[0.0, 0.0, 1.0, 0.0],[0.0,1.0,0.0,0.0]],[[0.0,0.0,0.0,1.0],[0.0,1.0,0.0,0.0]]])
        np.testing.assert_array_equal(output, expected_output)

if __name__ == '__main__':
    unittest.main()
