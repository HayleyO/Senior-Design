//
//  CTC_Decoding.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 3/28/22.
//

import Foundation


struct CTC_Decoding{
    
    let characters = [1:"a", 2:"b", 3:"c", 4:"d", 5:"e", 6:"f", 7:"g", 8:"h", 9:"i", 10:"j", 11:"k", 12:"l", 13:"m", 14:"n", 15:"o", 16:"p", 17:"q", 18:"r", 19:"s", 20:"t", 21:"u", 22:"v", 23:"w", 24:"x", 25:"y", 26:"z", 27:"'", 28:"?", 29:"!", 30:" ", 31:""]
    
    func CTC_Decode(input:[[Double]], input_len:Int) -> String{
        var pred_string = [""]
        var prev_class_ix = -1
        for t in 0...(input_len-1)
        {
            let row = input[t]
            let max_index = row.firstIndex(of: row.max()!)
            if max_index != prev_class_ix && max_index != 31
            {
                pred_string.append(characters[max_index!]!)
            }
            prev_class_ix = max_index ?? prev_class_ix
        }
        return pred_string.joined(separator: "")
    }
}


