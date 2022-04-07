//
//  DataController.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/16/22.
//  Written by Hannah Folkertsma
//

import SwiftUI
import CoreData

final class DataController: ObservableObject {
    static let Controller = DataController()
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        // if there are no PresetEntities
        /*if (presetsIsEmpty()) {
            initializePresets()
        }*/
    }
    
    //default presets
    /*func initializePresets() {
        let preset1 = PresetEntity(context: container.viewContext)
            preset1.id = UUID()
            preset1.name = "Indoors"
            preset1.weakValue = 30.0
            preset1.strongValue = 70.0
        let preset2 = PresetEntity(context: container.viewContext)
            preset2.id = UUID()
            preset2.name = "Outdoors"
            preset2.weakValue = 70.0
            preset2.strongValue = 100.0
        let preset3 = PresetEntity(context: container.viewContext)
            preset3.id = UUID()
            preset3.name = "Resturaunt"
            preset3.weakValue = 60.0
            preset3.strongValue = 105.0
        let preset4 = PresetEntity(context: container.viewContext)
            preset4.id = UUID()
            preset4.name = "Sleep"
            preset4.weakValue = 20.0
            preset4.strongValue = 50.0
        
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save default presets: \(error)")
        }
    }
    
    func presetsIsEmpty() -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PresetEntity")
        fetchRequest.fetchLimit =  1

        do {
            let count = try container.viewContext.count(for: fetchRequest)
            if count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
            return false
        }
    }
    
    func presetsIsEmpty() -> Bool {
        let presets = getAllPresets()
        let count = presets.count
        return count == 0
    }
    
    func getAllPresets() -> [PresetEntity]{
        let request: NSFetchRequest<PresetEntity> = PresetEntity.fetchRequest()
        do{
            return try container.viewContext.fetch(request)
        } catch {
            print("Error getting all presets \(error)")
            return []
        }
        
    }*/
    
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
      } catch {
          print("Error getting alarms \(error)")
          return []
      }
    }
    
    //get one alarm from core data using its ID
    func getAlarm(id: UUID) -> AlarmEntity?{
        let all = getAlarms()
        let alarm = all.first(where: {$0.id == id})
        if(alarm != nil){
            return alarm!
        }
        return nil
    }
    
    // delete the specified AlarmEntity
    func deleteAlarms(alarm: AlarmEntity){
        container.viewContext.delete(alarm)
        
        do{
            try container.viewContext.save()
            print("alarm deleted, hopefully")
        } catch {
            container.viewContext.rollback()
            print("Error deleting alarm")
        }
    }
    
    // save alarm to core data
    func saveAlarm(id: UUID, name: String, time: Date, desc: String, enabled: Bool){
        do{
            let existingAlarm = getAlarm(id: id)
            do{
                if(existingAlarm != nil)
                {
                    // if there is a preexisting alarm with the same id, delete it to be replaced
                    print("there is an existing alarm with this id")
                    deleteAlarms(alarm: existingAlarm!)
                }
            }
            // create a new AlarmEntity and save it
            let toSave = AlarmEntity(context: container.viewContext)
            toSave.name = name
            toSave.desc = desc
            toSave.alarmTime = time
            toSave.id = id
            toSave.isEnabled = enabled
            try container.viewContext.save()
            print("Alarm saved successfully")
        }
        catch {
            print("Failed to save alarm: \(error)")
        }
    }
}
