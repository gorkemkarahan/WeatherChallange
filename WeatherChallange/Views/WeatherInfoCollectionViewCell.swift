//
//  WeatherInfoCollectionViewCell.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit

class WeatherInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weatherEventIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare(for forecast: Forecast) {
        //NOTE: This might be more performant with prefetching
        if forecast.weather.count > 0 {
            self.weatherEventIcon.downloadAndCache(forecast.weather[0].getIconUrlString())
        }

        timeLabel.text = Formatters.shared.hourAndMinute(from: forecast.dt)
        degreeLabel.text = forecast.main.temp.degreeString
    }

}
