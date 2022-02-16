//
//  Vibration.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/15/22.
//

import Foundation

class Vibration: NSObject{
    func vibrate(volume: Float) {
        if volume > 90.0 {
            //big vibration
        }
        else if volume > 50.0 {
            //small vibration
        }
    }
}
