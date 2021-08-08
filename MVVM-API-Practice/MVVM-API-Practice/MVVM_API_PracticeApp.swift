//
//  MVVM_API_PracticeApp.swift
//  MVVM-API-Practice
//
//  Created by Cam on 8/8/21.
//

import SwiftUI

@main
struct MVVM_API_PracticeApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            WeatherView(viewModel: viewModel)
        }
    }
}
