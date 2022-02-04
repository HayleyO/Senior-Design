import csv
import numpy as np
import pandas as pd
import librosa
import sklearn
import soundfile as sf

pathESC50 = "../data/ESC-50-master/meta/esc50.csv"
pathAUDIO = "../data/ESC-50-master/audio"

def pull_from_csv(path):
    info = []
    with open(path, mode='r') as file:
        read = csv.reader(file)
        for line in read:
            info.append(line)
    return info

#WIP
def pull_mfcc_from_csv(path, mfccnum):
    info = []

    with open(path, mode='r') as file:
        read = csv.reader(file)
        fill = []
        j=0
        for line in read:
            if(j<mfccnum):
                fill.append(line)
                j+=1
            else:
                info.append(fill)
                j=0
                fill=[]

                fill.append(line)
                j+=1
        if(fill!=[]):
            info.append(fill)
    return info

def write_array_to_csv(path, content):
    with open(path, mode='w', newline='') as file:
        write = csv.writer(file)
        write.writerows(content)
        
#WIP
def write_mfcc_to_csv(path, content, mfccnum):
    print(len(content), "is this long going in...")
    with open(path, mode='w', newline='') as file:
        write = csv.writer(file)
        for i in range(len(content)):
            write.writerows(content[i])

def train_test_split(data, label):
    data_train, data_test, label_train, label_test = sklearn.model_selection.train_test_split(data, label, train_size = 0.9)
    return data_train, data_test, label_train, label_test

def normalize_data(dataset_data, mean, std):
    print(len(dataset_data[1][1]), len(dataset_data[1]))
    normalized_data = []
    # z scoring for normalization
    for i in range(len(dataset_data)):
        normal_section = []
        for mfcc in range(len(dataset_data[i])):
            normal = (dataset_data[i][mfcc] - mean) / std
            normal_section.append(normal)
        normalized_data.append(normal_section)
    return normalized_data

def process_to_data(mfccnum):
    #gather file data, make dataset and label arrays
    esc50_metadata = pull_from_csv(pathESC50)
    escLen = len(esc50_metadata)
    dataset_data = []
    dataset_label = []
    grandMean = 0
    grandStd = 0
    
    for i in range(1,escLen):
        pathWAV = pathAUDIO+"/"+esc50_metadata[i][0]

        data, samplerate = sf.read(pathWAV, dtype='float32')

        #collect MFCC (Mel-Frequency Cepstrum Coefficients) from WAV file, 431 samples [n_mfcc] times
        mfccList = librosa.feature.mfcc(y=data, sr=samplerate,n_mfcc=mfccnum)

        #mean and std computations for all MFCC values
        mean=0
        std = 0
        minimean = 0
        ministd = []

        for j in range(len(mfccList)):
            for val in mfccList[j]:
                minimean+=val
                ministd = np.append(ministd, val)
            minimean /= len(mfccList[j])
            ministd = np.std(ministd)
            mean += minimean
            std+=ministd

        print(i)
        mean /= len(mfccList)
        std /= len(mfccList)
        grandStd += std
        grandMean += mean
        
        dataset_data.append(mfccList)
        dataset_label.append(esc50_metadata[i][3])

    #normalize & return the data
    grandMean /= escLen
    grandStd /= escLen

    print(grandMean)
    print(grandStd)
                     
    normalized_data = normalize_data(dataset_data, grandMean, grandStd)
    data_train, data_test, label_train, label_test = train_test_split(normalized_data, dataset_label)

    print("Writing ", len(data_train))
    write_mfcc_to_csv("../data/svm_trainingdata.csv",data_train,mfccnum)
    write_array_to_csv("../data/svm_traininglabels.csv",label_train)
    print("Writing ", len(data_test))
    write_mfcc_to_csv("../data/svm_testdata.csv",data_test, mfccnum)
    write_array_to_csv("../data/svm_testlabels.csv",label_test)

    return data_train, data_test, label_train, label_test