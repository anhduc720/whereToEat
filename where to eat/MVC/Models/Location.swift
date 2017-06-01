//
//  Location.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/1/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation
class Location {
    var _lat: Double!
    var _lgn: Double!
    
    var latitude: Double {
        get {
            return _lat
        }
        set {
            _lat = newValue
        }
    }
    
    var longitude: Double {
        get {
            return _lgn
        }
        set {
            _lgn = newValue
        }
    }
    
    init(lat: Double, lgn: Double) {
        self._lat = lat
        self._lgn = lgn
    }
    
    func toParameter() {
        // TODO later
    }
    
    
}
