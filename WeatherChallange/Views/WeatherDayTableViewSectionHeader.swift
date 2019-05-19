//
//  WeatherDayTableViewSectionHeader.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit

class WeatherDayTableViewSectionHeader: UIView {

    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUIElements()
    }
    
    func prepareUIElements() {
        backgroundColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
    }

}
