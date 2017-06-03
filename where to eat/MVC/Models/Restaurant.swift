//
//  Restaurant.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation
class Restaurant : NSObject {
    
    private var _id: String!
    private var _name: String!
    private var _rating: Double!
    private var _address: String!
    private var _image: String!
    private var _lat: Double!
    private var _lgn: Double!
    private var _reviewCount: Int!
    private var _fone: String!
    private var _categories:String!
    
    var id:String! {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var name:String! {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var rating: Double! {
        get {
            return _rating
        }
        set {
            _rating = newValue
        }
    }
    
    var address: String! {
        get {
            return _address
        }
        set {
            _address = newValue
        }
    }
    
    var image: String! {
        get {
            return _image
        }
        set {
            _image = newValue
        }
    }
    
    var latitude: Double! {
        get {
            return _lat
        }
        set {
            _lat = newValue
        }
    }
    
    var longitude: Double! {
        get {
            return _lgn
        }
        set {
            _lgn = newValue
        }
    }
    
    var reviewCount:Int! {
        get {
            return _reviewCount
        }
        set {
            _reviewCount = newValue
        }
    }
    
    var foneNumber: String! {
        get {
            return _fone
        }
        set {
            _fone = newValue
        }
    }
    
    var categories: String! {
        get {
            return _categories
        }
        set {
            _categories = newValue
        }
    }
    
    init(place: NSDictionary) {
        
        if let id = place.value(forKey: "id") as? String {
            _id = id
        } else {
            _id = EMPTY_STRING
        }
        if let name = place.value(forKey: "name") as? String {
            _name = name
        } else {
            _name = EMPTY_STRING
        }
        if let rating = place.value(forKey: "rating") as? Double {
            _rating = rating
        } else {
            _rating = 0
        }
        if let location = place.value(forKey: "location") as? NSDictionary {
            if let address1 = location.value(forKey: "address1") as? String {
                if let address2 = location.value(forKey: "address2") as? String {
                    if let address3 = location.value(forKey: "address3") as? String {
                        _address = "\(address1) \(address2) \(address3))"
                    } else {
                        _address = "\(address1) \(address2)"
                    }
                } else {
                    _address = "\(address1)"
                }
            } else {
                _address = EMPTY_STRING
            }
        }
        
        if let image = place.value(forKey: "image_url") as? String {
            _image = image
        } else {
            _image = EMPTY_STRING
        }
        
        if let coordinates = place.value(forKey: "coordinates") as? NSDictionary {
            if let lat = coordinates.value(forKey: "latitude") as? Double {
                _lat = lat
            } else {
                _lat = 0
            }
            if let lgn = coordinates.value(forKey: "longitude") as? Double {
                _lgn = lgn
            } else {
                _lgn = 0
            }
            
        }
        
        if let review_count = place.value(forKey: "review_count") as? Int {
            _reviewCount = review_count
        } else {
            _reviewCount = 0
        }
        
        if let phone = place.value(forKey: "phone") as? String {
            _fone = phone
        } else {
            _fone = EMPTY_STRING
        }
        
        if let categories = place.value(forKey: "categories") as? [NSDictionary] {
            _categories = EMPTY_STRING
            for categori in categories {
                if let title = categori.value(forKey: "title") as? String {
                    if _categories == EMPTY_STRING {
                        _categories = "\(title)"
                    } else {
                        _categories = "\(_categories!), \(title)"
                    }
                }
            }
        }
    }
    
}
