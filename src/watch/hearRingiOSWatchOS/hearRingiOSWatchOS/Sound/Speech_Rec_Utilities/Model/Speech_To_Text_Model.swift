//
//  Speech_To_Text_Model.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 4/1/22.
//

import Foundation
import CoreML
    
func predict(input: [[Double]]) -> String
{
    var string = "Listening..."
    let temp_input = float_array_to_MLMultiArray(input: input)
    //print(MLMultiArray_to_float_array(input: temp_input, output_length: 193))
    do{
        let model = try stt()
        let prediction = try model.prediction(input: temp_input)
        let prediction_float = MLMultiArray_to_float_array(input: prediction.Identity)
        //print(prediction_float)
        string = CTC_Decode(input: prediction_float, input_len: prediction_float.count)
    }
    catch{
        print(error)
    }
    return string
}

func float_array_to_MLMultiArray(input: [[Double]]) -> MLMultiArray
{
    let length_1 = NSNumber(value: input.count)
    let length_2 = NSNumber(value: input[0].count)
    guard let mlArray = try? MLMultiArray(shape: [1, length_1, length_2], dataType: MLMultiArrayDataType.double) else{
        fatalError("Error with MLMultiArray Conversion")
    }
    
    for i in 0..<input.count
    {
        for j in 0..<input[i].count
        {
            mlArray[[0, i, j] as [NSNumber]] = (input[i][j]) as NSNumber
        }
    }
    
    return mlArray
}

func MLMultiArray_to_float_array(input:MLMultiArray, output_length:Int = 32) -> [[Double]]
{
    let length = input.count
    let length_1 = length/output_length
    let length_2 = output_length
    /*var array: [Float] = []
    
    for i in 0..<length
    {
        array.append(Float(truncating: input[[0,NSNumber(value: i)]]))
    }
     */
    var array = [[Double]](repeating: [Double](repeating: 0.0, count: length_2), count: length_1)

    for i in 0..<length_1
    {
        for j in 0..<length_2
        {
            array[i][j] = Double(truncating: input[[0, i, j] as [NSNumber]])
        }
        //array.append(Float(truncating: MLMultiArray[[0, NSNumber(value: i)]]))
    }
    return array
}
