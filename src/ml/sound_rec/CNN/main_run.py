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
            testFile = open("../../../../../audio/audio/16000/" + inputDF[1][0], "rb")
            weightsMatrixLength = len(testFile.read())//16

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
                for i in range(1, len(train_set)-1):
                    start = time()
                    currentFile = open("../../../../../audio/audio/16000/" + inputDF[train_set[i]][0], "rb")
                    sound = currentFile.read()
                    x_strings = []
                    currentWord = None
                    s = 0
                    start = time()
                    while (s+16) < len(sound):
                        currentWord = sound[s:s+16]
                        currentWord = int.from_bytes(currentWord, "little")
                        currentWord = float(currentWord)/18446744073709551615
                        x_strings.append(currentWord)
                        s += 16
                    currentFile.close()
                    
                    soundRecNN.x_values = np.array(x_strings)
                    for k in range(len(y_vals)):
                        if inputDF[train_set[i]][3] == y_vals[k]:
                            soundRecNN.y_value = k
                            break
                            
                    gradients = soundRecNN.trainNetwork()                    
                    
                    dF = np.add(dF, gradients[0])
                    dI = np.add(dI, gradients[2])
                    wgF = np.add(wgF, gradients[1])
                    wgI = np.add(wgI, gradients[3])
                    
                    if ((i!=0) and (i%49==0)):
                        soundRecNN.updateBiases(dF, dI)
                        soundRecNN.updateWeights(wgF, wgI)
                        
                        dF = np.zeros(len(biases2[0]))
                        wgF = np.zeros((len(weights2), len(weights2[0])))
                        dI = np.zeros(len(biases1[0]))
                        wgI = np.zeros((len(weights1), len(weights1[0])))
                    stop = time()
                    print(stop - start)
                    print((i)*(j+1))
            total = 0
            correct = 0
            for val in range(len(test_set)):
                total += 1
                currentFile = open("../../../../../audio/audio/16000/" + inputDF[test_set[val]][0], "rb")
                sound = currentFile.read()
                x_strings = []
                currentWord = None
                s = 0
                start = time()
                while (s+16) < len(sound):
                    currentWord = sound[s:s+16]
                    currentWord = int.from_bytes(currentWord, "little")
                    currentWord = float(currentWord)/18446744073709551615
                    x_strings.append(currentWord)
                    s += 16
                currentFile.close()
                for kill in range(len(y_vals)):
                    if inputDF[test_set[val]][3] == y_vals[kill]:
                        soundRecNN.y_value = kill
                        break
                soundRecNN.x_values = x_strings
                fire = soundRecNN.validate()
                if fire == soundRecNN.y_value:
                    correct += 1
                print(str(correct)+"/"+str(total) + ":" + str(float(correct)/total))
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