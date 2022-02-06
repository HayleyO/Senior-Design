import sklearn

class SVM:

	def __init__(self, x_train, x_test, y_train, y_test):
		self.x_train = x_train
		self.x_test = x_test
		self.y_train = y_train
		self.y_test = y_test

	def shuffledata(self,x,y):
		return sklearn.utils.shuffle(x,y)

