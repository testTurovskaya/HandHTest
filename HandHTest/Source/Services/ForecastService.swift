//
//  ForecastService.swift
//  HandHTest
//
//  Created by Надежда Туровская on 26.04.2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import Alamofire

let forecastService = ForecastService.shared

struct ForecastService{
    
    // MARK: - Public Properties
    
    static let shared = ForecastService()
    
    // MARK: - Private Properties
    
    fileprivate let url = "http://api.openweathermap.org/data/2.5/"
    fileprivate let key = "213a5fd56e3ae93cf9e0685fc9e33806"
    
    // MARK: - Public methods
    
    func getWeaterFor(cities: [CityId], completionHandler: @escaping (DataResponse<Any>) -> Void ){
        var cityIds = "group?id="
        for city in cities{
            cityIds += String.init(describing: city.rawValue) + ","
        }
        _ = cityIds.removeLast()
        cityIds += "&units=metric"
        let requestURL = url + cityIds + "&APPID=" + key
        print(requestURL)
        get(requestURL, completionHandler)
    }
    
    
    // MARK: - Private Methods
    
    fileprivate func get(_ url: String, _ completionHandler: @escaping (DataResponse<Any>) -> Void) {
        request(url,method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON{ response in
                completionHandler(response)
        }
    }
}
