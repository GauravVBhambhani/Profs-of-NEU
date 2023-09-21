//
//  Profs_of_NEUApp.swift
//  Profs of NEU
//
//  Created by Gaurav Bhambhani on 9/21/23.
//

import SwiftUI
import Firebase

@main
struct Profs_of_NEUApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
        
    }
}
