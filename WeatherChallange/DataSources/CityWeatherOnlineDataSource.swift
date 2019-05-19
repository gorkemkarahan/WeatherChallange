//
//  CityWeatherOnlineDataSource.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit

class CityWeatherOnlineDataSource: CityWeatherDataProvider {
    
    //MARK: Private Members
    private var cityWeather: CityWeather? {
        didSet {
            normalizedData = Dictionary(grouping: self.cityWeather!.list) { weather in Formatters.shared.normalizedDate(from: weather.dt) }
        }
    }
    private var normalizedData: [String: [Forecast]]?
    private var lastFetchTimeInterval: TimeInterval = 0
    
    
    var city: City? {
        get {
            return cityWeather?.city
        }
    }
    
    //MARK: Main functions
    func fetchData(completion: CityWeatherDataCompletion?) {

        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=745044&appid=fc1a49841a4078735584dbdc5cb2334f&units=metric")!
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            self?.lastFetchTimeInterval = Date().timeIntervalSince1970
            
            guard let data = data else {
            
                if let c = completion {
                    DispatchQueue.main.async{
                        c(nil, ErrorHelper.generalError)}
                }
                return
            }
            
            if let forecast = try? JSONDecoder().decode(CityWeather.self, from: data) {

                self?.cityWeather = forecast
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
        }
        task.resume()
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
        //NOTE: API Documents Suggest to not fetch data before 10 minutes
        if cityWeather == nil || ((Date().timeIntervalSince1970 - lastFetchTimeInterval) > (60 * 10)) {
            return true
        }
        return false
    }
    
}
