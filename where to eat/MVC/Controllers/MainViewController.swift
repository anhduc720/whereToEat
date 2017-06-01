//
//  MainViewController.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/1/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit
import GoogleMaps

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let _ =  APICallUtil.shared.accessToken {
            APICallUtil.shared.getRestaurants(zoom: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: LocationUtil.shared.lat, longitude: LocationUtil.shared.lgn, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }


}

