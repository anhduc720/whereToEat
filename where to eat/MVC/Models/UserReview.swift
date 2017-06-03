//
//  UserReview.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation

class UserReview {
    private var _rating: Double!
    private var _userName: String!
    private var _userImage: String!
    private var _text: String!
    private var _time: String!
    private var _url: String!
    
    var rating:Double! {
        get {
            return _rating
        }
        set {
            _rating = newValue
        }
    }
    var userName:String! {
        get {
            return _userName
        }
        set {
            _userName = newValue
        }
    }
    var userImage:String! {
        get {
            return _userImage
        }
        set {
            _userImage = newValue
        }
    }
    var text:String! {
        get {
            return _text
        }
        set {
            _text = newValue
        }
    }
    var time:String! {
        get {
            return _time
        }
        set {
            _time = newValue
        }
    }
    var url:String! {
        get {
            return _url
        }
        set {
            _url = newValue
        }
    }
    
    init(review: NSDictionary) {
        
        if let rating = review.value(forKey: "rating") as? Double{
            _rating = rating
        } else {
            _rating = 0
        }
        if let user = review.value(forKey: "user") as? NSDictionary {
            if let userName = user.value(forKey: "name") as? String {
                _userName = userName
            } else {
                _userName = EMPTY_STRING
            }
            if let userImage = user.value(forKey: "image_url") as? String {
                _userImage = userImage
            } else {
                _userImage = EMPTY_STRING
            }
        }
        if let text = review.value(forKey: "text") as? String {
            _text = text
        } else {
            _text = EMPTY_STRING
        }
        if let time = review.value(forKey: "time_created") as? String {
            _time = time
        } else {
            _time = EMPTY_STRING
        }
        if let url = review.value(forKey: "rating") as? String {
            _url = url
        } else {
            _url = EMPTY_STRING
        }
        
        
    }
}



