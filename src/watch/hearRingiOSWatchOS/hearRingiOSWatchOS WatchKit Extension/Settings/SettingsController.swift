//
//  SettingsController.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 3/21/22.
//

import Foundation
import CoreData
import SwiftUI


// https://stackoverflow.com/questions/26345189/how-do-you-update-a-coredata-entry-that-has-already-been-saved-in-swift
class SettingsController : NSObject, ObservableObject{
    @Environment(\.managedObjectContext) var moc

  /*  func updateSettings(bufferValue: Double, strongValue: Double, weakValue: Double){
        let threshold: ThresholdEntity!
        
        let fetch: NSFetchRequest<ThresholdEntity> = ThresholdEntity.fetchRequest()
        let results = try? moc.fetch(fetch)

         if results?.count == 0 {
            threshold = ThresholdEntity(context: moc)
         } else {
            threshold = results?.first
         }

        threshold.bufferValue = bufferValue
        threshold.weakValue = weakValue
        threshold.strongValue = strongValue
        
        try? moc.save()
        
        
    } */
}
