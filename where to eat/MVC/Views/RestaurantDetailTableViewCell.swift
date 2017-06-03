//
//  RestaurantDetailTableViewCell.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fone: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet var ratingStar: [UIImageView]!
    @IBOutlet weak var address: UILabel!
   
    func configureCell(restaurant: Restaurant) {
        name.text = restaurant.name!
        fone.text = "Fone: \(restaurant.foneNumber!)"
        categories.text = "Categories: \(restaurant.categories!)"
        address.text = "Address: \(restaurant.address!)"
        
        // Setting rating star image
        if var rateScore = restaurant.rating {
            for i in 0...4 {
                if rateScore >= 1.0 {
                    ratingStar[i].image = UIImage(named: "full-star")
                } else if rateScore > 0 {
                    ratingStar[i].image = UIImage(named: "half-star")
                } else {
                    ratingStar[i].image = UIImage(named: "empty-star")
                }
                rateScore = rateScore - 1
            }
        }
    }
    
}
