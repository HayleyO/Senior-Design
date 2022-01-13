import torch.nn as nn
from torch.nn.utils.rnn import pack_padded_sequence, pad_packed_sequence



#Data now needs to be padded and one hot encoded

class pBLSTMLayer(nn.Module):
    def __init__(self, input_feature_dim, hidden_dim, rnn_unit='LSTM',dropout_rate=0.0):
        super(pBLSTMLayer, self).__init__()

        #Because we'll be reducing the time dimensions by 2, we'll need to increase feature dimensions by two
        self.BLSTM =  nn.LSTM(input_feature_dim*2, hidden_dim,1, bidirectional=True, dropout=dropout_rate, batch_first=True)
    
    # Input shape should be [# of sample, timestep, features]
    def forward(self, input_x):
        batch_size = input_x.size(0)
        timestep = input_x.size(1)
        feature_dim = input_x.size(2)
        # As per the arvix paper:
        # "In each successive stacked pBLSTM layer, we reduce the time resolution by a factor of 2."
        input_x = input_x.contiguous().view(batch_size,int(timestep/2),feature_dim*2)
        output, hidden = self.BLSTM(input_x)
        return output, hidden

class Listener(nn.Module):
    def __init__(self, input_feature_dim, listener_hidden_dim, BLSTM_layers, rnn_unit, dropout_rate=0.0, **kwargs):
        super(Listener, self).__init__()
        """
        input_feature_dim: 39 (because of mfcc 39) [#num of sample, timestep, features]                     
        listener_hidden_dim: 256 (from paper)
        listener_layer: 3 (because of the paper)
        """
        self.BLSTM_layers = BLSTM_layers
        assert self.LSTM_layers>=1, 'Cant have a listener without at least one layer'
        
        #List of listeners
        pBLSTM = []
        pBLSTM.append(pBLSTMLayer(input_feature_dim,listener_hidden_dim, rnn_unit=rnn_unit, dropout_rate=dropout_rate))

        for i in range(1, self.BLSTM_layers):
            pBLSTM.append(pBLSTMLayer(listener_hidden_dim*2,listener_hidden_dim, rnn_unit=rnn_unit, dropout_rate=dropout_rate))

    def forward(self,input_x):
        output, _  = self.pBLSTM[0](input_x)
        for i in range(1,self.listener_layer):
            #As per the arvix paper:
            """In the pBLSTM model, we concatenate the outputs at consecutive steps of each layer before feeding it to the next layer, i.e.:
            h^j_i = pBLSTM(h^j_i, [h^(j-1)_2i, h^(j-1)_(2i+1)])"""
            output, _ = self.pBLSTM[i](output)
        
        return output

        

