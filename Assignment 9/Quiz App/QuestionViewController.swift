//
//  QuestionViewController.swift
//  Quiz App
//
//  Created by Saurabh Jaiswal on 3/16/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class QuestionViewController: UIViewController, CLLocationManagerDelegate {
    
    var queryName = ""
    var locationManager = CLLocationManager()

    @IBOutlet weak var queryQuestion: UILabel!
    
    @IBOutlet weak var getAnswerButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func getAnswerTapped(_ sender: UIButton) {
        findPlace()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocation()
       
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        // Do any additional setup after loading the view.
        queryQuestion.text = "What is the closest place for " + queryName + "?"
    }
    
    var geoCoder = CLGeocoder()
    
    func lookupLocation() {
        if let location = locationManager.location {
            geoCoder.reverseGeocodeLocation(location,
                                            completionHandler: geoCodeHandler)
        } }
    func geoCodeHandler (placemarks: [CLPlacemark]?, error: Error?) { if let placemark = placemarks?.first {
        if let name = placemark.name {
            print("place name = \(name)")
        }
        
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initializeLocation() { // called from start up method
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            startLocation()
        case .denied, .restricted:
            showAlert()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    // Delegate method called whenever location authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if ((status == .authorizedAlways) || (status == .authorizedWhenInUse)) { self.startLocation()
        } else {
            self.stopLocation()
        } }
    func startLocation () {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func stopLocation () {
        locationManager.stopUpdatingLocation()
    }
    
    // Delegate method called when location changes
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
//        if let latitude = location?.coordinate.latitude {
//            print("Latitude: \(latitude)")
//        }
//        if let longitude = location?.coordinate.longitude {
//            print("Longitude: \(longitude)")
//        }
//
    }
    
    // Delegate method called if location unavailable (recommended)
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("locationManager error: \(error.localizedDescription)") }
    
    
    func findPlace() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = queryName
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: searchHandler)
    }
    func searchHandler (response: MKLocalSearch.Response?, error: Error?) {
        if let err = error {
            showAlert()
            
//        print("Error occured in search: \(err.localizedDescription)")
            
        } else if let resp = response {
            locationManager.delegate = self
            let status = CLLocationManager.authorizationStatus()
            if status == .denied || status == .restricted {
                showAlert()
            }else{
                print("\(resp.mapItems.count) matches found")
                if resp.mapItems.count == 0 {
                    showAlert()
                }else { self.mapView.removeAnnotations(self.mapView.annotations)
                    for item in resp.mapItems {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = item.placemark.coordinate
                        annotation.title = item.name
                        self.mapView.addAnnotation(annotation)}
                
                }
            }
            
        
         }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error",message: "Unable to find nearby location for \(queryName).", preferredStyle: .alert)
        
        let goAction = UIAlertAction(title: "Okay", style: .default,
                                     handler: { (action) in
                                        // execute some code when this option is selected
                                      
        })
       
        
        alert.addAction(goAction)
        
        present(alert, animated: true, completion: nil)
    }

    }
    

