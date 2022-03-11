//
//  Vibration.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/15/22.
//

import Foundation
import WatchKit

class Vibration: NSObject{
    
    //tracks whether the change in decibel level is significant enough for a vibration
    var storedDecibel: Float = 0.0
    
    // vibrate according to decibel level
    // if a threshold is hit, vibrate
    // if the decibel level changes by 10 within the threshold, vibrate
    func vibrateOnSound(volume: Float) {
            if volume > 90.0 {
                if(storedDecibel < 90.0 || abs(storedDecibel - volume) > 10.0){
                    WKInterfaceDevice.current().play(.notification)
                }
            }
            else if volume > 50.0 {
                if(storedDecibel < 50.0 || abs(storedDecibel - volume) > 10.0){
                    WKInterfaceDevice.current().play(.directionUp)
                }
        }
        storedDecibel = volume
    }
    
    // vibrate for alarms 
    func vibrateAlarm(){
        WKInterfaceDevice.current().play(.notification)
    }
    
    func vibrateLow(){
        
    }
    
    func vibrateHigh(){
        
    }
}
