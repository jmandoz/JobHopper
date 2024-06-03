//
//  JobHopprApp.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI
import FirebaseCore

@main
struct JobHopprApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authManager: AuthManager = .init()
    
    init() {
        let appear = UINavigationBarAppearance()

        let atters: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "CooperHewitt-Medium", size: 42)!
        ]

        
        appear.largeTitleTextAttributes = atters
        appear.titleTextAttributes = atters
        appear.backgroundColor = .primaryBackground
        appear.shadowColor = .clear
        appear.shadowImage = UIImage()
        UINavigationBar.appearance().standardAppearance = appear
        UINavigationBar.appearance().scrollEdgeAppearance = appear
        UINavigationBar.appearance().shadowImage = .init() 
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView(authManager: authManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
