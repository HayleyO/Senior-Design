import torch
import torch.nn as nn


class Attend(nn.Module):  

    def __init__(self):
        super(Attend,self).__init__()

    # Queries are the decoder states, values are the encoder features
    def forward(self, queries, values):

        # Dot product attention
        # Taken from the paper "Attention is All You Need": https://arxiv.org/pdf/1706.03762.pdf

        # Attention = Softmax((Queries * Keys^T)/sqrt(d_k)) * V)
        attention_scores = torch.bmm(queries, values.transpose(1, 2)).squeeze(dim=1)
        attention = [self.softmax(attention_scores)]
        context = torch.sum(values*attention[0].unsqueeze(2).repeat(1,1,values.size(2)),dim=1)

        return attention, context