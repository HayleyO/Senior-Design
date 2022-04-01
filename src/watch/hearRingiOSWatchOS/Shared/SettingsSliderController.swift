//
//  SettingsSliders.swift
//  hearRingiOSWatchOS
//
//  Created by Hannah Folkertsma on 3/28/22.
//

import Foundation

class SettingsSliderController: NSObject, ObservableObject{
    let controller = DataController()
    let shared = Connectivity.shared
    
    func sliderChanged(value: Double, slider: sliders, highThreshold: Double = 0.0, lowThreshold: Double = 0.0){
        print("slider value changed to \(value)")
        if(slider == sliders.low){
            controller.updateSettings(buffer: 10, weak: value, strong: highThreshold)
            shared.send(bufferValue: 10, strongValue: highThreshold, weakValue: value, delivery: .highPriority)
        }
        else if(slider == sliders.high){
            controller.updateSettings(buffer: 10, weak: lowThreshold, strong: value)
            shared.send(bufferValue: 10, strongValue: value, weakValue: lowThreshold, delivery: .highPriority)
        }
    }
    
}

enum sliders{
    case low
    case high
}
