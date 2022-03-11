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
    @Published var strr: String = "disabled"
    
    
    static let shared = Connectivity()

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
    }
    
    public func send(AlarmTime: Date, alarmEnabled: Bool, alarmID: UUID, alarmName: String, Settings: String = "", delivery: DeliveryPriority,
                     replyHandler: (([String: Any]) -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        //If not activated or watch/app not present, do not run function
        guard canSendToPeer() else {return}
          
        let AlarmSettingsInfo: [String: Any] = [
            "alarmEnabled" : alarmEnabled,
            "alarmTime": 4,
            "alarmID": 4,
            "alarmName": 4,
            
            "SettingsPlaceholder": Settings
        ]
        
        print("Sending info to watch now")
        switch delivery {
            case .failable:
            WCSession.default.sendMessage(AlarmSettingsInfo,
                replyHandler: optionalMainQueueDispatch(handler: replyHandler),
                errorHandler: optionalMainQueueDispatch(handler: errorHandler)
            )

            case .guaranteed:
                WCSession.default.transferUserInfo(AlarmSettingsInfo)

            case .highPriority:
                do {
                    try WCSession.default.updateApplicationContext(AlarmSettingsInfo)
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
        print("Watch has context")
        update(from: userInfo)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any] = [:]) {
        update(from: applicationContext)
    }
    
    private func update(from dictionary: [String : Any]) {
        print("Updating info now")
        
        var alarmEnabled = dictionary["alarmEnabled"] as? Bool
        
        print("Transferred Settings and Alarm data")
            
        #if os(watchOS)
        if(alarmEnabled == true) {
            self.strr = "enabled"
        } else {
            self.strr = "disabled"
        }
        #endif
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
