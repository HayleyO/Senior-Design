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

def normalize_data(dataset_array):
    return dataset_array

def process_to_array():
    #gather file data, make dataset matrix
    esc50_metadata = pull_from_csv(pathESC50)

    dataset_array = []
    for i in range(1,len(esc50_metadata)):
        pathWAV = pathAUDIO+"/"+esc50_metadata[i][0]
        fileWAV = wave.open(pathWAV,'r')
        fileBytes = fileWAV.readframes(fileWAV.getnframes())
        fileArray = np.frombuffer(fileBytes, dtype=np.int16)
        dataset_array.append((fileArray,esc50_metadata[i][3]))

    #preprocess & return the data
    normalized_array = normalize_data(dataset_array)
    return normalized_array
