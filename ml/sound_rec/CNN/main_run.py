from csvparser import *
from cNN import *
import numpy as np
from math import e
from time import time
from random import randint

while True:
    try:
        ans = input("Would you like to train or test a neural network? ")

        ans = ans.lower()
        if ans == "train":
            testFile = open("../../../audio/audio/16000/" + inputDF[1][0], "rb")
            weightsMatrixLength = len(testFile.read())//64

            y_vals = []
            
            for val in range(1, len(inputDF)):
                y = inputDF[val][3]
                y_vals.append(y)
            
            y_vals = set(y_vals)
            y_vals = list(y_vals)
            
            biases1 = generateRandomBiases(HIDDEN_NODES_L2, "biases_hidden_L1.csv")
            biases2 = generateRandomBiases(len(y_vals), "biases_final.csv")
            
            weights2 = generateRandomWeights(len(y_vals), HIDDEN_NODES_L2, "weights_hidden_L2.csv")
            weights1 = generateRandomWeights(HIDDEN_NODES_L2, weightsMatrixLength, "weights_hidden_L1.csv")
            
            soundRecNN = Neural_Network(weights1, weights2, biases1, biases2)
            
            train_set = []
            test_set = []
            
            for num in range(len(inputDF)):
                magicN = randint(0, 9)
                if ((magicN == 6) or (magicN == 7)):
                    test_set.append(num)
                else:
                    train_set.append(num)
            dF = np.zeros(len(biases2[0]))
            wgF = np.zeros((len(weights2), len(weights2[0])))
            dI = np.zeros(len(biases1[0]))
            wgI = np.zeros((len(weights1), len(weights1[0])))
            for j in range(15):
                for i in range(1, len(train_set)):
                    start = time()
                    currentFile = open("../../../audio/audio/16000/" + inputDF[train_set[i]][0], "rb")
                    sound = currentFile.read()
                    x_strings = []
                    currentWord = None
                    s = 0
                    while (s+64) < len(sound):
                        currentWord = sound[s:s+64]
                        currentWord = int.from_bytes(currentWord, "little")
                        currentWord = float(currentWord)/13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084095
                        x_strings.append(currentWord)
                        s += 64
                    
                    currentFile.close()
                    
                    soundRecNN.x_values = np.array(x_strings)
                    for k in range(len(y_vals)):
                        if inputDF[i][3] == y_vals[k]:
                            soundRecNN.y_value = k
                            break
                    
                    gradients = soundRecNN.trainNetwork()
                    for g in range(len(dF)):
                        dF[g] += gradients[0][g]
                    for h in range(len(dI)):
                        dI[h] += gradients[2][h]
                        
                    for a in range(len(wgF)):
                        for b in range(len(wgF[a])):
                            wgF[a][b] += gradients[1][a][b]
                    
                    for c in range(len(wgI)):
                        for d in range(len(wgI)):
                            wgI[c][d] += gradients[3][c][d]
                    
                    stop = time()
                    print(stop - start)
                    if ((i!=0) and (i%49==0)):
                        soundRecNN.updateBiases(dF, dI)
                        soundRecNN.updateWeights(wgF, wgI)
        elif ans == "test":
            biases1 = readCSV(input("What is your file where your first bias matrix is stored? "))
            biases2 = readCSV(input("What is your file where your second bias matrix is stored? "))
            
            weights1 = readCSV(input("What is your file where your first weights matrix is stored? "))
            weights2 = readCSV(input("What is your file where your first weights matrix is stored? "))

            soundRecNN = Neural_Network(weights1, weights2, biases1, biases2)
        else:
            print("Please select either 'test' or 'train.'")
    except KeyboardInterrupt:
        break