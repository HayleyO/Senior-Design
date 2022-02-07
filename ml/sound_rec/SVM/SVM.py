import sklearn
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

class SVM:	

	def __init__(self, x_train, x_test, y_train, y_test):
		self.x_train = x_train
		self.x_test = x_test
		self.y_train = y_train
		self.y_test = y_test
		self.clf = make_pipeline(StandardScaler(),sklearn.svm.SVC(kernel='rbf', decision_function_shape='ovr',C=1000,gamma=0.0001))

	def shuffledata(self,x,y):
		return sklearn.utils.shuffle(x,y)

	def train_test(self):
		self.clf.fit(self.x_train, self.y_train)
		y_pred = self.clf.predict(self.x_test)
		print("Accuracy: ", sklearn.metrics.accuracy_score(self.y_test, y_pred))