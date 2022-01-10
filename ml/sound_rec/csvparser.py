import pandas as pd

readPath = "../../../ESC50.csv"

inputDF = pd.read_csv(readPath)

#currentFile = open("../../../audio/audio/" + inputDF["filename"][0], "rb")
#sound = currentFile.read()
    
for i in range(len(inputDF["filename"])):
    currentFile = open("../../../audio/audio/" + inputDF["filename"][i], "rb")
    sound = currentFile.read()
    #here, we need to be ready to process the information
    currentFile.close()