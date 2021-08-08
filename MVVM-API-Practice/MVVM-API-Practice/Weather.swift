//
//  Weather.swift
//  MVVM-API-Practice
//
//  Created by Cam on 8/8/21.
//

import Foundation

public struct Weather {
    let city: String
    let temp: String
    let description: String
    let iconName: String
    
    init(response: APIResponse) {
        city = response.name
        temp = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}
