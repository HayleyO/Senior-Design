import csv
import wave
import numpy as np
import pandas as pd

pathESC50 = "../data/ESC-50-master/meta/esc50.csv"
pathOUT = "data.csv"
pathAUDIO = "../data/ESC-50-master/audio"

def pull_from_csv(path):
    info = []
    i=0
    with open(path, mode='r') as file:
        read = csv.reader(file)
        for line in read:
            i+=1
            info.append(line)
    return info

def write_to_csv(path, content):
    with open(path, mode='w', newline='') as file:
        write = csv.writer(file)
        write.writerows(content)

def normalize_data(dataset_array, mean, std):
    normalized_array = []
    # z scoring for normalization
    for i in range(len(dataset_array)):
        normal = (dataset_array[i][0] - mean) / std
        normalized_array.append([normal, dataset_array[i][1]])
    return normalized_array

def process_to_array():
    #gather file data, make dataset matrix
    esc50_metadata = pull_from_csv(pathESC50)
    escLen = len(esc50_metadata)
    dataset_array = []
    grandMean = 0
    grandStd = 0
    
    for i in range(1,escLen):
        pathWAV = pathAUDIO+"/"+esc50_metadata[i][0]
        fileWAV = wave.open(pathWAV,'r')
        fileBytes = fileWAV.readframes(fileWAV.getnframes())
        fileArray = np.frombuffer(fileBytes, dtype=np.int16)

        mean = fileArray.sum() / len(fileArray)
        grandMean += mean
        std=np.std(fileArray)
        grandStd += std
        
        dataset_array.append([fileArray,esc50_metadata[i][3]])

    #preprocess & return the data
    grandMean /= escLen
    grandStd /= escLen
                     
    normalized_array = normalize_data(dataset_array, grandMean, grandStd)
    return normalized_array
