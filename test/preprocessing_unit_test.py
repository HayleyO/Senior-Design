import unittest
import numpy as np
import sys, os
sys.path.append('src//ml//speech_rec//LAS//preprocessing')

from preprocessing_TIMIT import calc_norm_param, normalize, set_type

class TestPreprocessTIMIT(unittest.TestCase):

    def test_calc_norm_param(self):
        input_val = [np.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]])]
        mean, std_dev, len = calc_norm_param(input_val)
        np.testing.assert_array_equal(mean, np.array([3.5, 4.5, 5.5, 6.5, 7.5]))
        np.testing.assert_array_equal(std_dev, np.array([2.5, 2.5, 2.5, 2.5, 2.5]))
        self.assertEqual(len, 2)        

    def test_normalize(self):
        input_val = [np.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]])]
        mean = np.array([3.5, 4.5, 5.5, 6.5, 7.5])
        std_dev = np.array([2.5, 2.5, 2.5, 2.5, 2.5])
        output = normalize(input_val, mean, std_dev)
        np.testing.assert_array_equal(output, [np.array([[-1., -1., -1., -1., -1.], [1.,  1.,  1.,  1.,  1.]])])

    def test_set_type(self):
        input_val = [np.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]])]
        type = 'float32'
        output = set_type(input_val, type)
        self.assertEqual(type, output[0].dtype)

if __name__ == '__main__':
    unittest.main()