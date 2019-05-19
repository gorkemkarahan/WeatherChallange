//
//  CityGeneralInfoView.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit

class CityGeneralInfoView: UIView {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    
    func prepare(for city: City?, forecast: Forecast?) {
        cityNameLabel.text = city?.name ?? "-"
        if let tForecast = forecast {
            degreeLabel.text = tForecast.main.temp.degreeString
            descriptionLabel.text = tForecast.weather[0].description
            currentWeatherImageView.downloadAndCache(tForecast.weather[0].getIconUrlString())
        } else {
            degreeLabel.text = "-"
            descriptionLabel.text = "-"
            currentWeatherImageView.image = nil
        }
    }
    
    //NOTE: Activity indicator can be added, hence the name
    func switchToLoading(_ loading: Bool) {
        cityNameLabel.isHidden = loading
        degreeLabel.isHidden = loading
        descriptionLabel.isHidden = loading
        currentWeatherImageView.isHidden = loading
    }
}
