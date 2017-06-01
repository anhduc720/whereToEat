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
    func getToken() {
        if let token = UserDefaults.standard.object(forKey: "access_token") as? String {
            accessToken = token
            print(accessToken!)
        } else {
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

    }
    
    func getRestaurants(zoom:Double?) {

        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Authorization"] = "Bearer \(APICallUtil.shared.accessToken!)"
        let url = "\(YELP_SEARCH_API)?latitude=\(LocationUtil.shared.lat)&longitude=\(LocationUtil.shared.lgn)&radius=5000&categories=restaurants"
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            if response.error != nil {
                print(response.error?.localizedDescription as Any)
            } else {
                print(response.result.value as Any)
            }
        }
    }
}
