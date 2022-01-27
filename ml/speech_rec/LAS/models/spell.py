import torch.nn as nn
from attend import Attend

class Speller(nn.Module):
    def __init__(self, output_class_dim = 63, speller_hidden_dim=512, max_label_len=77, listener_hidden_dim=256, decode_mode = 0):
        super(Speller, self).__init__()

        """
        Output_class_dim : 63 for the 61 phoenems + tags (start/end)
        Speller_hidden_dim : Ouput dimension from LAS paper is 512
        Listener_hidden_dim : Default is 256 from paper
        """
        self.max_label_len = max_label_len
        self.label_dim = output_class_dim
        self.decode_mode = decode_mode
        # "CharacterDistribution is an MLP with softmax outputs over characters, and RNN is a 2 layer LSTM."
        # https://arxiv.org/pdf/1508.01211.pdf
        self.rnn_layer = self.LSTM(output_class_dim+speller_hidden_dim,speller_hidden_dim,num_layers=2,batch_first=True)
        self.attention = Attend()
        self.mlp = nn.Linear(speller_hidden_dim*2,output_class_dim)
        self.softmax = nn.LogSoftmax(dim=-1)


    def forward(self, encouder_output, ground_truth=None, teacher_force_rate = 0.9):

        batch_size = encouder_output.size()[0] # Because the batch size is the included in the x format

