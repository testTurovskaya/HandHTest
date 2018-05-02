//
//  Weather.swift
//  HandHTest
//
//  Created by Надежда Туровская on 26.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//
import UIKit

struct Weather{
    
    // MARK: - Public Properties
    var city = ""
    var temperature = ""
    var icon:UIImage? = nil
    
    // MARK: - Initializers
    init(by forecast : Forecast) {
        city = forecast.name
        let cesium  = Int(forecast.main.temp)
        temperature =  cesium > 0 ? "+"  : ""
        temperature += String.init(describing: cesium).degree
        let description = forecast.weather[0].description
        icon = matchIcon(description)
    }
    
    // MARK: - Private Methods
    fileprivate func matchIcon(_ description: String) -> UIImage? {
        guard let description = WeatherIcon.init(rawValue: description) else { return #imageLiteral(resourceName: "thunderstorm")}
        switch description{
        case .brokenClouds, .scatteredClouds:
            return #imageLiteral(resourceName: "scattered_clouds")
        case .clearSky:
            return #imageLiteral(resourceName: "clear_sky")
        case .fewClouds:
            return #imageLiteral(resourceName: "few_clouds")
        case .showerRain, .rain:
            return #imageLiteral(resourceName: "rain")
        case .thunderstorm:
            return #imageLiteral(resourceName: "thunderstorm")
        default:
            return #imageLiteral(resourceName: "scattered_clouds")
        }
        
    }
}
 // MARK: - Enum with icons
enum WeatherIcon: String {
    case fewClouds = "few clouds"
    case clearSky = "clear sky"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case showerRain = "shower rain"
    case rain = "rain"
    case thunderstorm = "thunderstorm"
    case snow = "snow"
    case mist = "mist"
}

