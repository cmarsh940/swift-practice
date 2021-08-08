//
//  NavigationPracticeApp.swift
//  NavigationPractice
//
//  Created by Cam on 8/7/21.
//

import SwiftUI

@main
struct NavigationPracticeApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.red]
    }
    var body: some Scene {
        WindowGroup {
            RedOneView()
        }
    }
}
