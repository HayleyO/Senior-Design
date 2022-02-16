//
//  Vibration.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/15/22.
//

import Foundation
import WatchKit

class Vibration: NSObject{
    func vibrateOnSound(volume: Float) {
        if volume > 90.0 {
            WKInterfaceDevice.current().play(.notification)
            print("big vibrate")
        }
        else if volume > 50.0 {
            WKInterfaceDevice.current().play(.click)
            print("small vibrate")
        }
    }
}
