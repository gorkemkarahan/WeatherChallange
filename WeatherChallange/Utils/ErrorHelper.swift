//
//  ErrorHelper.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 20.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit

class ErrorHelper: Any {
    
    static var generalError: Error {
        get {
            return DataSourceError.generalError(description: "An error occured please try again later")
        }
    }
    
}
