//
//  Formatters.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import Foundation

//NOTE: Singleton used to create a single formatter instead of creating new formatters each time
class Formatters {
    
    let formatter = DateFormatter()
    
    static let shared = Formatters()
    
    private init(){}
    
    
    /// Returns a string representation of a date with only hour and minute
    ///
    /// - Parameter date: date to process
    /// - Returns: string such as 22:30
    func hourAndMinute(from date: Date) -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    /// Returns a string representation of a TimeInterval with only hour and minute
    ///
    /// - Parameter timeInterval: date to process
    /// - Returns: string such as 22:30
    func hourAndMinute(from timeInterval: TimeInterval) -> String {
        return Formatters.shared.hourAndMinute(from: Date(timeIntervalSince1970: timeInterval))
    }
    
    func normalizedDate(from timeInterval: TimeInterval) -> String {
        formatter.dateFormat = "dd/MM EEEE"
        return formatter.string(from: Date(timeIntervalSince1970: timeInterval))
    }
}
