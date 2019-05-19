//
//  CityWeatherFileDataSource.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 20.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//


import Foundation

class CityWeatherFileDataSource: CityWeatherDataProvider {
    
    //MARK: Private Members
    private var cityWeather: CityWeather? {
        didSet {
            normalizedData = Dictionary(grouping: self.cityWeather!.list) { weather in Formatters.shared.normalizedDate(from: weather.dt) }
        }
    }
    private var normalizedData: [String: [Forecast]]?
    
    var city: City? {
        get {
            return cityWeather?.city
        }
    }
    
    //MARK: Main Functions
    func fetchData(completion: CityWeatherDataCompletion?) {
        if let filePath = Bundle.main.url(forResource: "745044", withExtension: "json") {
            do {
                let data = try Data(contentsOf: filePath, options: .mappedIfSafe)
                if let forecast = try? JSONDecoder().decode(CityWeather.self, from: data) {
                    self.cityWeather = forecast
                    if let c = completion {
                        DispatchQueue.main.async{
                            c(nil, nil)
                        }
                    }
                } else {
                    if let c = completion {
                        DispatchQueue.main.async{
                            c(nil, ErrorHelper.generalError)
                        }
                    }
                }
            } catch {
                if let c = completion {
                    DispatchQueue.main.async{
                        c(nil, ErrorHelper.generalError)
                    }
                }
            }
        }
    }
    
    func numberOfSections() -> Int {
        return normalizedData?.keys.count ?? 0
    }
    
    func forecasts(for section: Int) -> [Forecast]? {
        if let nD = normalizedData {
            return nD[nD.keys.sorted()[section]]
        }
        return nil
    }
    
    func needsFetch() -> Bool {
        return cityWeather == nil
    }
    
}
