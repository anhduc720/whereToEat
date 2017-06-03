//
//  LocationUtil.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/1/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation
import CoreLocation

class LocationUtil: NSObject, CLLocationManagerDelegate {
    static let shared: LocationUtil = { LocationUtil() }()
    let locationManager =  CLLocationManager()
    var lat: Double = 0
    var lgn: Double = 0
    
    func startUpdateLocation() {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 50
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lat = locations[0].coordinate.latitude
        lgn = locations[0].coordinate.longitude
        print(locations[0])
    }
    
}
