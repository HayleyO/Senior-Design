//
//  settingsModel.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 3/13/22.
//

import Foundation

class SettingsModel : NSObject, ObservableObject{
    var lowThreshold = 50.0
    var highThreshold = 90.0
}
