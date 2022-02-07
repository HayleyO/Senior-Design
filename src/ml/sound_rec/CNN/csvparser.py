import csv
from random import random

def readCSV(path):
    csvlines = []
    with open(path, mode='r') as infile:
        csvFile = csv.reader(infile)
        for line in csvFile:
            csvlines.append(line)
    return csvlines

def generateRandomBiases(layerNodes, outfile):
    biasMatrix = []
    for i in range(layerNodes):
        biasMatrix.append([random()])
    
    with open(outfile, "w") as OUT:
        csvwriter = csv.writer(OUT)
        csvwriter.writerows(biasMatrix)
    return biasMatrix

def generateRandomWeights(length, height, outfile):
    weightsMatrix = []
    for i in range(length):
        row = []
        for j in range(height):
            row.append(random())
        weightsMatrix.append(row)
        
    with open(outfile, "w") as OUT:
        csvwriter = csv.writer(OUT)
        csvwriter.writerows(weightsMatrix)
    return weightsMatrix
        