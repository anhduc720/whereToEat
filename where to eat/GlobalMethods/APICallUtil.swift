//
//  APICallUtil.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/1/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation
import Alamofire

class APICallUtil : NSObject {
    
    static let shared: APICallUtil = { APICallUtil() }()
    var accessToken:String?
    
    
    /// Get access token to Yelp
    func getToken() {
        var parameter: Parameters = Parameters()
        parameter["grant_type"] = "client_credentials"
        parameter["client_id"] = "h36UBjXK-W1J1oZqfiphcQ"
        parameter["client_secret"] = "EjYyaoL3WmVzbA7IJJuR9gh629L31k9Bo0aD7Pz3qUaKzfzJZj5L8j1v6QM71ymG"
        Alamofire.request(YELP_GET_TOKEN, method: .post, parameters: parameter, encoding: URLEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error?.localizedDescription as Any)
            } else {
                if let result = response.result.value as? [String:Any] {
                    if let access_token = result["access_token"] as? String {
                        self.accessToken = access_token
                        UserDefaults.standard.set(access_token, forKey: "access_token")
                    }
                }
            }
        }
        
        
    }
    
    
    /// Get restaurants list
    ///
    /// - Parameters:
    ///   - lat: latitude
    ///   - lgn: longitude
    ///   - radius: radius to search
    ///   - competionHandle: call back to UI
    func getRestaurants(lat: Double, lgn: Double, radius: Double, competionHandle : @escaping CompetionHandle) {
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Authorization"] = "Bearer \(APICallUtil.shared.accessToken!)"
        let url = "\(YELP_SEARCH_API)?latitude=\(lat)&longitude=\(lgn)&radius=\(Int(radius))&categories=restaurants"
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
                break
            case .success(let JSON):
                competionHandle(JSON as! NSDictionary)
                break
            }
            
        }
    }
    
    
    /// Get image
    ///
    /// - Parameters:
    ///   - url: image url
    ///   - competitionHandle: call back to UI
    func getImage(url: String, competitionHandle: @escaping (Data) -> ()) {
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Authorization"] = "Bearer \(APICallUtil.shared.accessToken!)"
        Alamofire.request(url, method: .get, headers: headers).responseData { respone in
            switch respone.result {
            case .failure(let error):
                print(error.localizedDescription)
                break
            case .success(let data):
                competitionHandle(data)
            }
        }
    }
    
    
    /// Get restaurant reviews
    ///
    /// - Parameters:
    ///   - id: place id
    ///   - competionHandle: call back to UI
    func getRestaurantsReview(id: String, competionHandle : @escaping CompetionHandle) {
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Authorization"] = "Bearer \(APICallUtil.shared.accessToken!)"
        let url = "\(YELP_GET_DETAIL)\(id)/reviews".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
                break
            case .success(let JSON):
                competionHandle(JSON as! NSDictionary)
                break
            }
            
        }
    }
    
}
