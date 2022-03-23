//
//  DataController.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/16/22.
//  Edited by Hannah Folkertsma on 3/22/22.
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
    
    // save a new ThresholdEntity object to core data
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
    
    // fetch one ThresholdEntity from core data
    func getSettings() -> ThresholdEntity{
        let request: NSFetchRequest<ThresholdEntity> = ThresholdEntity.fetchRequest()
        var result: [ThresholdEntity]
        do{
            try result = container.viewContext.fetch(request)
        } catch {
            print ("Error getting settings \(error)")
            return ThresholdEntity(context: container.viewContext)
        }
        return result.first ?? ThresholdEntity(context: container.viewContext)
    }
    
    // fetch all ThresholdEntities in core data
    func getAllSettings() -> [ThresholdEntity]{
        let request: NSFetchRequest<ThresholdEntity> = ThresholdEntity.fetchRequest()
        do{
            return try container.viewContext.fetch(request)
        } catch {
            print("Error getting all settings \(error)")
            return []
        }
        
    }
    
    // delete the specified ThresholdEntity
    func deleteSettings(settings: ThresholdEntity){
        container.viewContext.delete(settings)
        
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Error deleting settings")
        }
    }
    
    // update settings and ensure there is only ever one object
   func updateSettings(buffer: Double, weak: Double, strong: Double){
        let results = getAllSettings()

       if results.count > 0{
           for setting in results{
           deleteSettings(settings: setting)
           }
       }
       saveSettings(buffer: buffer, weak: weak, strong: strong)
        
    }
    
    // Get all alarms from core data
    func getAlarms() -> [AlarmEntity]{
        let alarmRequest: NSFetchRequest<AlarmEntity> = AlarmEntity.fetchRequest()
      do{
          return try container.viewContext.fetch(alarmRequest)
        }
            catch
        {
                print("Error fetching alarms")
                return []
            }
    }
}
