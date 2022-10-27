//
//  verdantVegan2App.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//

import SwiftUI
import Firebase
import UIKit



@main
struct verdantVeganApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate


    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            LoginPageView()
                .environmentObject(viewModel)
                .navigationViewStyle(.stack)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           return true
        }
}
