import tensorflow as tf
import coremltools

from tensorflow import keras
from keras.layers.normalization.layer_normalization import *
from keras.layers.normalization.batch_normalization import *


def CTCLoss(y_true, y_pred):
    # Compute the training-time loss value
    batch_len = tf.cast(tf.shape(y_true)[0], dtype="int64")
    input_length = tf.cast(tf.shape(y_pred)[1], dtype="int64")
    label_length = tf.cast(tf.shape(y_true)[1], dtype="int64")

    input_length = input_length * tf.ones(shape=(batch_len, 1), dtype="int64")
    label_length = label_length * tf.ones(shape=(batch_len, 1), dtype="int64")

    loss = keras.backend.ctc_batch_cost(y_true, y_pred, input_length, label_length)
    return loss


model = keras.models.load_model('ctc_model.h5', custom_objects={'CTCLoss': CTCLoss})
coreml_model = coremltools.converters.convert(model)
output = "model.mlmodel"
print("[INFO] saving model as {}".format(output))
coreml_model.save(output)