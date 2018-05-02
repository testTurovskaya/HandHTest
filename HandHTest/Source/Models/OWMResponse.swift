//
//  OWMResponse.swift
//  HandHTest
//
//  Created by Надежда Туровская on 26.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

struct OWMResponse: Decodable{
    var list: [Forecast]
}
struct Forecast: Decodable {
    var weather:[OWMWeather]
    var main:Temperature
    var name: String
}
struct Temperature: Decodable{
    var temp : Double
}

struct OWMWeather : Decodable {
    var description : String
}

