from csvparser import *
from cNN import *

while True:
    try:
        ans = input("Would you like to train or test a neural network? ")

        ans = ans.lower()
        if ans == "train":
            testFile = open("../../../audio/audio/" + inputDF[1][0], "rb")
            weightsMatrixLength = len(testFile.read())//64
            print(weightsMatrixLength)
            
            biases1 = generateRandomBiases(HIDDEN_NODES_L2, "biases_hidden_L1.csv")
            biases2 = generateRandomBiases(49, "biases_final.csv")
            
            weights2 = generateRandomWeights(HIDDEN_NODES_L2, 49, "weights_hidden_L2.csv")
            weights1 = generateRandomWeights(weightsMatrixLength, HIDDEN_NODES_L2, "weights_hidden_L1.csv")
            
            soundRecNN = Neural_Network(weights1, weights2, biases1, biases2)
            for i in range(1, len(inputDF)):
                currentFile = open("../../../audio/audio/" + inputDF[i][0], "rb")
                sound = currentFile.read()
                x_strings = []
                currentWord = None
                s = 0
                while (s+64) < len(sound):
                    currentWord = sound[s:s+64]
                    x_strings.append(currentWord)
                    s += 64
                print(len(x_strings))
                currentFile.close()
            print(len(weights1))
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