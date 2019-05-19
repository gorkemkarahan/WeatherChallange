//
//  UIKitExtensions.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

import UIKit


//NOTE: Simple cache to keep images can be improved with active downloading images and operation queues
let imageCache = NSCache<AnyObject, UIImage>()

extension UIImageView {
    
    /// Downloads image to cache if it is not in cache returns the image directly otherwise
    ///
    /// - Parameter urlString: url as string to download and cache
    func downloadAndCache(_ urlString: String) {
        
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { [weak self]
            (data, response, error)  in
            if let response = data, let img = UIImage(data: response) {
                DispatchQueue.main.async {
                    imageCache.setObject(img, forKey: urlString as AnyObject)
                    self?.image = img
                }
            }
            }.resume()
    }
}
