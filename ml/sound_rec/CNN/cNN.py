from csvparser import *
import numpy as np
from math import e

HIDDEN_NODES_L2 = 500

readPath = "../../../ESC50.csv"

inputDF = readCSV(readPath)

class Neural_Network:
    def __init__(self, weights1, weights2, biases1, biases2):
        self.weights_L1 = self.setWeights(weights1)
        self.weights_L2 = self.setWeights(weights2)
        self.biases_L1 = self.setBiases(biases1)
        self.biases_L2 = self.setBiases(biases2)
        self.x_values = []
        self.y_value = 0
    
    def getWeights(self):
        return self.weights
    
    def setWeights(self, weights):
        try:
            for val in weights:
                return np.array(weights) 
        except:
            print("Weights values aren't currently iterable.")
            return 0
    
    def getBiases(self):
        return self.biases
    
    def setBiases(self, biases):
        try:
            for val in biases:
                return np.array(biases)           
        except:
            print("Bias values aren't currently iterable.")
            return 0
    
    def trainNetwork(self):
        activationsSet = self.feedForwardPass()
        
        dF = self.deltaFinals(activationsSet[1])
        wgF = self.wgFinals(activationsSet[0], dF)
        dI = self.deltaIntermediates(activationsSet[0], dF)
        wgI = self.wgIntermediates(self.x_values[:], dI)
        
        return (dF, wgF, dI, wgI)
    
    def feedForwardPass(self):
        activations = []
        for i in range(len(self.weights_L1)):
            wx = 0
            for j in range(len(self.x_values)):
                wx += self.weights_L1[i][j] * self.x_values[j]
            z = wx + self.biases_L1[i]
            a = (1/((1+e)**(-z)))
            activations.append(a)
        
        activations2 = []
        for m in range(len(self.weights_L2)):
            wx = 0
            for n in range(len(activations)-1):
                wx += self.weights_L2[m][n] * activations[n]
            z = wx + self.biases_L1[m]
            a = (1/((1+e)**(-z)))
            activations2.append(a)
            
        return activations, activations2
    
    def deltaFinals(self, activations_L2):
        iMatrix = np.zeros((50, 50))
        for i in range(len(iMatrix)):
            for j in range(len(iMatrix[i])):
                if i == j:
                    iMatrix[i][j] = 1
        
        yOneHot = iMatrix[self.y_value]
        dF = np.zeros(len(yOneHot))
        
        for k in range(len(dF)):
            dF[k] = (activations_L2[k]-yOneHot[k])*activations_L2[k]*(1-activations_L2[k])
        
        return dF
    
    def wgFinals(self, activations_L2, deltaF):
        wgF = np.zeros((len(deltaF), len(activations_L2)))
        
        for i in range(len(deltaF)):
            for j in range(len(activations_L2)):
                wgF[i][j] = deltaF[i] * activations_L2[j] 
        return wgF
    
    def deltaIntermediates(self, activations_L1, deltaF):
        dI = np.zeros(len(self.weights_L2[0]))
        
        for i in range(len(self.weights_L2[0])):
            sumWeightsGradients = 0
            for j in range(len(deltaF)):
                sumWeightsGradients += self.weights_L2[j][i] * deltaF[j]
            dI[i] = sumWeightsGradients * activations_L1[i] * (1-activations_L1[i])
        return dI
    
    def wgIntermediates(self, activations_L1, deltaI):
        wgI = np.zeros((len(deltaI), len(activations_L1)))
        
        for i in range(len(deltaI)):
            for j in range(len(activations_L1)):
                wgI[i][j] = deltaI[i] * activations_L1[j]
        return wgI
    
    def updateBiases(self, dF, dI):
        eta = .22
        miniBatches = 50
        
        for i in range(len(dF)):
            self.biases_L2[i] -= (eta/miniBatches)*dF[i]
        for j in range(len(dI)):
            self.biases_L1[j] -= (eta/miniBatches)*dI[i]
    def updateWeights(self, wgF, wgI):
        eta = .22
        miniBatches = 50
        
        for i in range(len(wgF)):
            for j in range(len(wgF[i])):
                self.weights_L2[i][j] -= (eta/miniBatches)*wgF[i][j]
            
        for m in range(len(wgI)):
            for n in range(len(wgI)):
                self.weights_L1[m][n] -= (eta/miniBatches)*wgI[m][n]
    
