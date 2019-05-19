//
//  CityOnlineDataSource.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit

class CityOnlineDataSource: Any {

    
    func fetchDataFromAPI() {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=745044&appid=fc1a49841a4078735584dbdc5cb2334f")!
        
        //TODO: Weakify
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        
    }
    
}
