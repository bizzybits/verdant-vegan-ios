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
struct verdantVegan2App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @StateObject var ingredientViewModel: IngredientViewModel = IngredientViewModel()

    var body: some Scene {
        WindowGroup {
//            NavigationView{
            let viewModel = AppViewModel()
            LoginPageView()
                .environmentObject(viewModel)
//            }
                .navigationViewStyle(.stack)
            //    .environmentObject(listViewModel)
            //    .environmentObject(ingredientViewModel)
           
        }
    }
}
