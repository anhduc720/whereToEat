//
//  RestaurantDetailTableViewCell.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit
import GoogleMaps

class RestaurantDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapImage: UIImageView!
 
    func configureCell(restaurant: Restaurant) {
        let mark = "&markers=color:red%7Clabel:C%7C\(restaurant.latitude!),\(restaurant.longitude!)"
        let size = "&size=\(Int(mapImage.frame.size.width))x\(Int(mapImage.frame.size.height))"
        let url = "\(GOOGLE_STYLE)\(restaurant.latitude!),\(restaurant.longitude!)\(mark)\(size)"
        print(url)
        mapImage.imageFromServerURL(urlString: url)
    }
    
}
