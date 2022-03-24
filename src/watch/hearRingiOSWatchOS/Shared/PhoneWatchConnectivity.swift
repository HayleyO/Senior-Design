//
//  PhoneWatchConnectivity.swift
//  hearRingiOSWatchOS
//
//  Created by Jason on 2/17/22.
//

import SwiftUI
import Foundation
import WatchConnectivity
import CoreData

final class Connectivity : NSObject, ObservableObject
{
    @StateObject private var data_controller = DataController()
    @Environment(\.managedObjectContext) var moc
    
    //published variables for use elsewhere
    @Published var strr: String = "disabled"
    @Published var AlarmChanged: AlarmInfo = AlarmInfo(alarmID: UUID(), alarmName: "NameUnknown", alarmTime: Date.now, alarmEnabled: false, alarmDescription: "DescriptionUnknown")
    @Published var SettingsChanged: SettingsInfo = SettingsInfo(bufferValue: 0.0, weakValue: 0.0, strongValue: 0.0)
    
    static let shared = Connectivity()
    
    struct AlarmInfo: Codable {
        let alarmID: UUID
        let alarmName: String
        let alarmTime: Date
        let alarmEnabled: Bool
        let alarmDescription: String
    }
    
    struct SettingsInfo: Codable {
        let bufferValue: Double
        let weakValue: Double
        let strongValue: Double
    }

    override private init() {
        super.init()
        #if !os(watchOS)
        guard WCSession.isSupported() else {
          return
        }
        #endif

        WCSession.default.delegate = self
        WCSession.default.activate()
        print("Activated connectivity")
        print(WCSession.default.activationState == .notActivated)
        WCSession.default.activate()
    }
    
    //sends an alarm whenever alarm arguments are supplied
    public func send(AlarmTime: Date, alarmEnabled: Bool, alarmID: UUID, alarmName: String, alarmDescription: String, delivery: DeliveryPriority) {
        //If not activated or watch/app not present, do not run function
        guard canSendToPeer() else {return}
          
        let AlarmInfoObj = AlarmInfo(alarmID: alarmID, alarmName: alarmName, alarmTime: AlarmTime, alarmEnabled: alarmEnabled, alarmDescription: alarmDescription)
        
        do{
            let EncodeAlarmInfoObj = try JSONEncoder().encode(AlarmInfoObj)
            let AlarmToData = try JSONEncoder().encode("Alarm")
            
            if let jsonString = String(data: EncodeAlarmInfoObj, encoding: .utf8) {
                print("JSON \(jsonString)")
            }
            let SendingDict = ["JSON":EncodeAlarmInfoObj, "SettingsOrAlarm":AlarmToData]
            
            deliver(SendingDict: SendingDict, delivery: delivery)
            
        }
        catch{}
    }
    
    //sends Settings whenever settings are changed
    public func send(bufferValue: Double, strongValue: Double, weakValue: Double, delivery: DeliveryPriority) {
        //If not activated or watch/app not present, do not run function
        guard canSendToPeer() else {return}
          
        let SettingsInfoObj = SettingsInfo(bufferValue: bufferValue, weakValue: weakValue, strongValue: strongValue)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let EncodeAlarmInfoObj = try encoder.encode(SettingsInfoObj)
            let SettingsToData = try JSONEncoder().encode("Settings")
            
            if let jsonString = String(data: EncodeAlarmInfoObj, encoding: .utf8) {
                print("JSON \(jsonString)")
            }
            let SendingDict = ["JSON":EncodeAlarmInfoObj, "SettingsOrAlarm":SettingsToData]
            
            deliver(SendingDict: SendingDict, delivery: delivery)
        }
        catch{}
    }
    
    //Gets around the issue of not being able to connect to watch to send first alarm
    public func SendFirst() {
        let useless = try? JSONEncoder().encode(1)
        let garbage = try? JSONEncoder().encode("not useful")
        deliver(SendingDict: ["Useless":useless!, "SettingsOrAlarm":garbage!], delivery: .guaranteed)
    }
    
    //delivers, based on priority, encoded JSON string to companion device
    public func deliver(SendingDict: [String: Data], delivery: DeliveryPriority, replyHandler: (([String: Any]) -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        print("Sending info to watch now")
        
        switch delivery {
            //will attempt to immediately send once, returns error on failure
            case .failable:
            WCSession.default.sendMessage(SendingDict,
                replyHandler: optionalMainQueueDispatch(handler: replyHandler),
                errorHandler: optionalMainQueueDispatch(handler: errorHandler)
            )
            //will try to send no matter what when connection is available
            case .guaranteed:
                WCSession.default.transferUserInfo(SendingDict)

            //will try to send most recent message with highest priority on connection availability
            case .highPriority:
                do {
                    try WCSession.default.updateApplicationContext(SendingDict)
                } catch { errorHandler?(error) }
        }
    }
    
    //for making code slightly cleaner
    typealias OptionalHandler<T> = ((T) -> Void)?
    private func optionalMainQueueDispatch<T>(handler: OptionalHandler<T>) -> OptionalHandler<T> {
        guard let handler = handler else {
            return nil
        }
        return {
            item in DispatchQueue.main.async { handler(item) }
        }
    }
    
    private func canSendToPeer() -> Bool {
        guard WCSession.default.activationState == .activated else {return false}
        
        #if os(watchOS)
        guard WCSession.default.isCompanionAppInstalled else {return false}
        #else
        guard WCSession.default.isWatchAppInstalled else {return false}
        #endif
        
        return true
    }
}

// MARK: - WCSessionDelegate
extension Connectivity: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
      
    }
    
    // This method is called when a message is sent with failable priority
    // *and* a reply was requested.
    func session(_ session: WCSession, didReceiveMessage message: [String: Any],
        replyHandler: @escaping ([String: Any]) -> Void
    ) {
        update(from: message)

        let key = "alarmEnabled"
        replyHandler([key: true])
    }

    // This method is called when a message is sent with failable priority
    // and a reply was *not* requested.
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        update(from: message)
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        update(from: userInfo)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any] = [:]) {
        update(from: applicationContext)
    }
    
    private func update(from dictionary: [String : Any]) {
        print("Updating info now")
        
        do {
            //decode and set received settings
            let SettingsOrAlarm = try? JSONDecoder().decode(String.self, from: dictionary["SettingsOrAlarm"] as! Data)
            if(SettingsOrAlarm == "Settings") {
                let decodedSettings = try JSONDecoder().decode(SettingsInfo.self, from: dictionary["JSON"] as! Data)
                print("Debug settings received")
                print("weak val set to: \(decodedSettings.weakValue)")
                print("strong val set to: \(decodedSettings.strongValue)")
                print("threshold val set to: \(decodedSettings.bufferValue)")
                
            //decode and set received alarm
            } else if(SettingsOrAlarm == "Alarm") {
                let decodedAlarm = try JSONDecoder().decode(AlarmInfo.self, from: dictionary["JSON"] as! Data)
                AlarmChanged = decodedAlarm
                #if os(watchOS)
                let AlarmEnabled = decodedAlarm.alarmEnabled
                if(AlarmEnabled == true) {
                    self.strr = "enabled"
                    print(decodedAlarm.alarmEnabled)
                } else {
                    self.strr = "disabled"
                    print(decodedAlarm.alarmEnabled)
                }
                #endif
                print("Alarm Infodump below")
                print(decodedAlarm.alarmEnabled)
                print(decodedAlarm.alarmID)
                print(decodedAlarm.alarmTime)
                print(decodedAlarm.alarmName)
                print(decodedAlarm.alarmDescription)
                print("\n")
                //only happens on first send to watch
            } else {
                return
            }
        } catch {}
        print("Transferred data successfully")
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
      
    }

    //used for connecting and disconnecting multiple watches
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
      
    }
    #endif
}
