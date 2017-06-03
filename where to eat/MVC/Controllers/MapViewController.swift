//
//  MapViewController.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit
import GoogleMaps

import ACProgressHUD_Swift

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var markList = [GMSMarker]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocationUtil.shared.locationManager.delegate = LocationUtil.shared.self
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: LocationUtil.shared.lat, longitude: LocationUtil.shared.lgn, zoom: 12)
        let mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapview.isMyLocationEnabled = true
        createMark(map: mapview)
        mapview.delegate = self
        mapview.settings.compassButton = true
        mapview.settings.myLocationButton = true
        LocationUtil.shared.locationManager.delegate = self
        view = mapview
    }
    
    /// create marker
    ///
    /// - Parameter map: mapview
    func createMark(map: GMSMapView) {
        for restaurant in DataUtil.shared.restaurantList {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.4)
            marker.userData = restaurant
            marker.map = map
            marker.icon = UIImage(named: "marker")
            markList.append(marker)
        }
        // Remove which mark not in map
        for marker in markList {
            if markList.count > 0 {
                if !(map.projection.contains(marker.position)) {
                    marker.map = nil
                    markList = markList.filter({ $0 != marker })
                }
            }

        }
    }
    
    
    /// Go to place detail view
    ///
    /// - Parameters:
    ///   - mapView: mapview
    ///   - marker: which marker be tapped
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        performSegue(withIdentifier: "mapToDetailSegue", sender: marker.userData)
    }

    /// Register custom info window
    ///
    /// - Parameters:
    ///   - mapView: mapview
    ///   - marker: marker
    /// - Returns: info window view
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        marker.tracksInfoWindowChanges = true
        let view = RestaurantCustomView(frame: CGRect(x: 0, y: 0, width: 270, height: 90))
        if let place = marker.userData as? Restaurant {
            DispatchQueue.main.async {
                view.configureCell(restaurant: place)
            }
        }
        return view
     }
    
    
    /// Update restaurant list and map when change position
    ///
    /// - Parameters:
    ///   - mapView: mapview
    ///   - position: new camera position
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let lat = mapView.camera.target.latitude
        let lgn = mapView.camera.target.longitude
        DataUtil.shared.getRestaurantList(lat: lat, lgn: lgn, radius: mapView.getRadius()) {
            self.createMark(map: mapView)
        }
    }
    
    
    /// update camera by location
    ///
    /// - Parameters:
    ///   - manager: location manager
    ///   - locations: new location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mapview = view as! GMSMapView
        mapview.camera = GMSCameraPosition.camera(withTarget: locations[0].coordinate, zoom: mapview.camera.zoom)
    }
    
    
    /// passing data to detail view
    ///
    /// - Parameters:
    ///   - segue: segue
    ///   - sender: data to send
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToDetailSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let restautant = sender as? Restaurant {
                    destination.restaurant = restautant
                }
            }
        }
    }
    
    
    /// show navigation bar when long press to map view
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - coordinate: coordinate
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
