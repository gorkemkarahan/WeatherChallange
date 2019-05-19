//
//  WeatherDayTableViewCell.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit

class WeatherDayTableViewCell: UITableViewCell {
    
    var forecasts: [Forecast]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let kCellIdentifier = String(describing: WeatherInfoCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: kCellIdentifier, bundle: nil), forCellWithReuseIdentifier: kCellIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension WeatherDayTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as? WeatherInfoCollectionViewCell {
            if let forecast = forecasts?[indexPath.row] {
                cell.prepare(for: forecast)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension WeatherDayTableViewCell: UICollectionViewDelegate {
    
}

extension WeatherDayTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 118)
    }
}

