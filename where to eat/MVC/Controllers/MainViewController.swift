//
//  MainViewController.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/1/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit
import CoreLocation
import ACProgressHUD_Swift

class MainViewController: UIViewController, CLLocationManagerDelegate {

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.hidesBarsOnTap = false
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// go to mapview
    ///
    /// - Parameter sender: action when request complete
    @IBAction func findRestaurants(_ sender: Any) {
        self.performSegue(withIdentifier: "mainToMapSegue", sender: nil)
    }
}

