//
//  CityWeatherDataProvider./swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 20.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import Foundation

typealias CityWeatherDataCompletion = (_ message: String?, _ error: Error?) -> Void

enum DataSourceError: Error {
    case generalError(description: String)
}

protocol CityWeatherDataProvider {
    var city: City? { get }
    func needsFetch() -> Bool
    func fetchData(completion: CityWeatherDataCompletion?)
    func numberOfSections() -> Int
    func forecasts(for section: Int) -> [Forecast]?
}
