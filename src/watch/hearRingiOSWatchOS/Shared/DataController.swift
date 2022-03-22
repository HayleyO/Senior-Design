//
//  DataController.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/16/22.
//

import SwiftUI
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveSettings(buffer: Double, weak: Double, strong: Double){
        let thresholds = ThresholdEntity(context: container.viewContext)
        thresholds.bufferValue = buffer
        thresholds.weakValue = weak
        thresholds.strongValue = strong
        
        do{
            try
            container.viewContext.save()
            print("Settings saved successfully")
            
        } catch {
            print("Failed to save thresholds: \(error)")
        }
    }
    
    func getSettings() -> [ThresholdEntity]{
        let request: NSFetchRequest<ThresholdEntity> = ThresholdEntity.fetchRequest()
        do{
            print("getting values")
            return try container.viewContext.fetch(request)
        } catch {
            print ("Error getting settings \(error)")
            return []
        }
    }
    
    func deleteSettings(settings: ThresholdEntity){
        container.viewContext.delete(settings)
        
        do{
            try container.viewContext.save()
            print("Successfully deleted settings object")
        } catch {
            container.viewContext.rollback()
            print("Error deleting settings")
        }
    }
    
   /* func updateSettings(buffer: Double, strong: Double, weak: Double){
        let threshold: ThresholdEntity!
        
        let fetch: NSFetchRequest<ThresholdEntity> = ThresholdEntity.fetchRequest()
        let results = try? container.viewContext.fetch(fetch)

         if results?.count == 0 {
             threshold = ThresholdEntity(context: container.viewContext)
         } else {
            threshold = results?.first
         }

        threshold.bufferValue = buffer
        threshold.weakValue = weak
        threshold.strongValue = strong
        
        try? container.viewContext.save()
        
        
    } */
}
