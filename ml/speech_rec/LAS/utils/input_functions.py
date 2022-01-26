import numpy as np





## TAKEN FROM: https://github.com/AzizCode92/Listen-Attend-and-Spell-Pytorch/blob/530f8ff2871c5b86294f06dbc6f3a61ad772d13f/util/timit_dataset.py#L67


# Input x: list of np array with shape (timestep,feature)
# Return new_x : a np array of shape (len(x), padded_timestep, feature)
def ZeroPadding(x,pad_len):
    features = x[0].shape[-1]
    new_x = np.zeros((len(x),pad_len,features))
    for idx,ins in enumerate(x):
        new_x[idx,:len(ins),:] = ins
    return new_x

# A transfer function for LAS label
# We need to collapse repeated label and make them onehot encoded
# each sequence should end with an <eos> (index = 1)
# Input y: list of np array with shape ()
# Output tuple: (indices, values, shape)
def OneHotEncode(Y,max_len,max_idx=61):
    new_y = np.zeros((len(Y),max_len,max_idx+2))
    for idx,label_seq in enumerate(Y):
        last_value = -1
        cnt = 0
        for label in label_seq:
            if last_value != label:
                new_y[idx,cnt,label+2] = 1.0
                cnt += 1
                last_value = label
        new_y[idx,cnt,1] = 1.0 # <eos>
    return new_y