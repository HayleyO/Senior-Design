import numpy as np
import torch
import numpy as np
import torch.nn as nn
from attend import Attend
from utils.training_functions import CreateOnehotVariable
class Speller(nn.Module):
    def __init__(self, output_class_dim = 63, speller_hidden_dim=512, max_label_len=77):
        super(Speller, self).__init__()

        """
        Output_class_dim : 63 for the 61 phoenems + tags (start/end)
        Speller_hidden_dim : Ouput dimension from LAS paper is 512
        """
        self.max_label_len = max_label_len
        self.label_dim = output_class_dim
        # "CharacterDistribution is an MLP with softmax outputs over characters, and RNN is a 2 layer LSTM."
        # https://arxiv.org/pdf/1508.01211.pdf
        self.rnn_layer = self.LSTM(output_class_dim+speller_hidden_dim,speller_hidden_dim,num_layers=2,batch_first=True)
        self.attention = Attend()
        self.mlp = nn.Linear(speller_hidden_dim*2,output_class_dim)
        self.softmax = nn.LogSoftmax(dim=-1)

    def forward_step(self,input_word, last_hidden_state,listener_feature):
        rnn_output, hidden_state = self.rnn_layer(input_word,last_hidden_state)
        #Attention context of rnn outputs and H
        attention_score, context = self.attention(rnn_output,listener_feature)
        concat_feature = torch.cat([rnn_output.squeeze(dim=1),context],dim=-1)
        #Softmax of rnn ouptuts and attention 
        raw_pred = self.softmax(self.mlp(concat_feature))
        return raw_pred, hidden_state, context, attention_score

    def forward(self, encouder_output):

        batch_size = encouder_output.size()[0] # Because the batch size is the included in the x format
        output_word = CreateOnehotVariable(self.float_type(np.zeros((batch_size,1))),self.label_dim)
        rnn_input = torch.cat([output_word,encouder_output[:,0:1,:]],dim=-1)

        max_step = self.max_label_len

        hidden_state = None
        raw_pred_seq = []
        attention_record = []

        for step in range(max_step):
            raw_pred, hidden_state, context, attention_score = self.forward_step(rnn_input, hidden_state, encouder_output)
            raw_pred_seq.append(raw_pred)
            attention_record.append(attention_score)

            output_word = torch.zeros_like(raw_pred)
            for idx,i in enumerate(raw_pred.topk(1)[1]):
                output_word[idx,int(i)] = 1
            output_word = output_word.unsqueeze(1)    

            rnn_input = torch.cat([output_word,context.unsqueeze(1)],dim=-1) 
        
        return raw_pred_seq, attention_record

