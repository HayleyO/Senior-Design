//
//  CTC_Decoding.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 3/28/22.
//

import Foundation


struct CTC_Decoding{
    
    var characters = [1:"a", 2:"b", 3:"c", 4:"d", 5:"e", 6:"f", 7:"g", 8:"h", 9:"i", 10:"j", 11:"k", 12:"l", 13:"m", 14:"n", 15:"o", 16:"p", 17:"q", 18:"r", 19:"s", 20:"t", 21:"u", 22:"v", 23:"w", 24:"x", 25:"y", 26:"z", 27:"'", 28:"?", 29:"!", 30:" ", 31:""]
    
    func CTC_Decode(input:Array<Array<<Float>>>, input_len:Int) -> String{
        let pred_string = [""]
        let prev_class_ix = -1
        for t in 0...(input_len-1)
        {
            let row = input[t]
            let max_index = row.index(of: row.max())
        }
        return ""
    }
}


