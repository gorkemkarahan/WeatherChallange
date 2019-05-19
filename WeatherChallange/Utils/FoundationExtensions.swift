//
//  FoundationExtensions.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import Foundation

extension Double {
    var degreeString: String {
        get {
            return String(format: "%.0f°", self)
        }
    }
}
