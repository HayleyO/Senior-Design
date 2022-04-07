//
//  SettingsSliders.swift
//  hearRingiOSWatchOS
//
//  Created by Hannah Folkertsma on 3/28/22.
//

import Foundation


class SettingsSliderController: NSObject, ObservableObject{
    let controller = DataController.Controller
    let shared = Connectivity.shared
    
    var updated_from_connectivity: Bool = false
    
    func sliderChanged(value: Double, slider: sliders, highThreshold: Double = 0.0, lowThreshold: Double = 0.0){
        print("slider value changed to \(value)")
        if(slider == sliders.low){
            controller.updateSettings(buffer: 10, weak: value, strong: highThreshold)
            if(!updated_from_connectivity) {
                shared.send(bufferValue: 10, strongValue: highThreshold, weakValue: value, delivery: .highPriority)
            } else {
                updated_from_connectivity = false
                
            }
        }
        else if(slider == sliders.high){
            controller.updateSettings(buffer: 10, weak: lowThreshold, strong: value)
            if(!updated_from_connectivity) {
                shared.send(bufferValue: 10, strongValue: value, weakValue: lowThreshold, delivery: .highPriority)
            } else {
                updated_from_connectivity = false
                
            }
        }
    }
}

enum sliders{
    case low
    case high
}
