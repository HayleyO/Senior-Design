//
//  Speech_To_Text_Model.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 4/1/22.
//

import Foundation
import CoreML

struct Speech_To_Text{
    
    func predict(input: MLMultiArray)
    {
        do{
            let model = try stt()
            let prediction = try model.prediction(input: input)
            print(prediction)
        }
        catch{
            print(error)
        }
    }
}
