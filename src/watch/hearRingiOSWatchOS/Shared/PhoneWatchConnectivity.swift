//
//  PhoneWatchConnectivity.swift
//  hearRingiOSWatchOS
//
//  Created by Jason on 2/17/22.
//

import Foundation
import WatchConnectivity

final class Connectivity : NSObject, ObservableObject {
    @Published var alarmsShare: [String] = []
    @Published var settingsShare: [String] = []
    
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
    }
    
    public func send(Alarms: [String], Settings: [String], delivery: DeliveryPriority, errorHandler: ((Error) -> Void)? = nil) {
        //If not activated or watch/app not present, do not run function
        guard WCSession.default.activationState == .activated else {return}
        
        #if os(watchOS)
        guard WCSession.default.isCompanionAppInstalled else {
            return
        }
        #else
        guard WCSession.default.isWatchAppInstalled else {
            return
        }
        #endif
          
        let userInfo: [String: [String]] = [
            "alarmGroup" : Alarms,
            "settingsGroup": Settings
        ]
        
        switch delivery {
            case .failable:
                break

            case .guaranteed:
                WCSession.default.transferUserInfo(userInfo)

            case .highPriority:
                do {
                    try WCSession.default.updateApplicationContext(userInfo)
                } catch { errorHandler?(error) }
        }
    }
}

// MARK: - WCSessionDelegate
extension Connectivity: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
      
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        update(from: userInfo)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any] = [:]) {
        update(from: applicationContext)
    }
    
    private func update(from dictionary: [String : Any]) {
        var key = "alarmGroup"
        guard let alarms = dictionary[key] as? [String] else {return}
        self.alarmsShare = alarms
        
        key = "settingsGroup"
        guard let settingss = dictionary[key] as? [String] else {return}
        self.settingsShare = settingss
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
      
    }

    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
      
    }
    #endif
}
