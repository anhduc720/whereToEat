//
//  DataUtil.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation

class DataUtil {
    
    static let shared: DataUtil = { DataUtil() }()
    var restaurantList  = [Restaurant]()
    
    
    /// restaurant list
    ///
    /// - Parameters:
    ///   - lat: latitude of center mapview
    ///   - lgn: longitude of center mapview
    ///   - radius: radius to search
    ///   - competionHandle: callback to UI
    func getRestaurantList(lat: Double, lgn: Double, radius: Double, competionHandle: @escaping () -> ()) {
        self.restaurantList.removeAll()
        APICallUtil.shared.getRestaurants(lat: lat, lgn: lgn, radius: radius) { JSON in
            if let places = JSON.value(forKey: "businesses") as? [NSDictionary] {
                self.restaurantList.removeAll()
                for place in places {
                    let restaurant = Restaurant(place: place)
                    self.restaurantList.append(restaurant)
                }
            }
            competionHandle()
        }
    }
}
