from csvparser import *

HIDDEN_NODES_L2 = 500

readPath = "../../../ESC50.csv"

inputDF = readCSV(readPath)

class Neural_Network:
    def __init__(self, weights1, weights2, biases1, biases2):
        self.weights_L1 = self.setWeights(weights1)
        self.weights_L2 = self.setWeights(weights2)
        self.biases_L1 = self.setBiases(biases1)
        self.biases_L2 = self.setBiases(biases2)
    
    def getWeights(self):
        return self.weights
    
    def setWeights(self, weights):
        try:
            for val in weights:
                return weights 
        except:
            print("Weights values aren't currently iterable.")
            return 0
    
    def getBiases(self):
        return self.biases
    
    def setBiases(self, biases):
        try:
            for val in biases:
                return biases           
        except:
            print("Bias values aren't currently iterable.")
            return 0
