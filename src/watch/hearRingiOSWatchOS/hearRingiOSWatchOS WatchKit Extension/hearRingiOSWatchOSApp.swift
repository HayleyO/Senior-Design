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
    @StateObject var controller = DataController()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                SettingsView()
                    .environment(\.managedObjectContext, controller.container.viewContext)
            }
            .tabViewStyle(PageTabViewStyle())
        }
       
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
