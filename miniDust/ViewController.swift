//
//  ViewController.swift
//  ScrollViews
//
//  Created by kpugame on 2016. 4. 21..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        //경고창
        let alert = UIAlertView()
        alert.title = "사용법"
        alert.message = "아래의 '미세먼지 예보'탭에서 \n현재 위치를 기준으로 미세먼지 정보를 \n확인할 수 있습니다."
        alert.addButtonWithTitle("확인")
        alert.show()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        let locationData = MyLocation.sharedInstance
        
        locationData.WGS84_x = region.center.latitude
        locationData.WGS84_y = region.center.longitude
        
        //print(locationData.WGS84_x)
        //print(locationData.WGS84_y)
        //print("%@", region.center)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    
}
