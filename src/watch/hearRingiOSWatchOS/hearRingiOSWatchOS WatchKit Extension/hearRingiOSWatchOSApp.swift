//
//  hearRingiOSWatchOSApp.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI
@main
struct hearRingiOSWatchOSApp: App {
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var extensionDelegate
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                SettingsView()
            }
            .tabViewStyle(PageTabViewStyle())
        }
       
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
