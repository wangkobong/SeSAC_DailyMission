//
//  TheaterLocationViewController.swift
//  TrendMediaProject
//
//  Created by sungyeon kim on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI // iOS15 LocationButton

class TheaterLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self ,action: #selector(closeButtonPressed))
 
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self ,action: nil)
        navigationItem.rightBarButtonItem?.title = "filter"
        
        let location = CLLocationCoordinate2D(latitude: 37.498282917564765, longitude: 127.02763571410598)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotaion = MKPointAnnotation()
        annotaion.title = "강남역"
        annotaion.coordinate = location
        mapView.addAnnotation(annotaion)
        
        mapView.delegate = self
        locationManager.delegate = self

    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - MKMapViewDelegate
extension TheaterLocationViewController: CLLocationManagerDelegate {
    
    func checkUserLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요")
        }
    }
    

    
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() //위치 접근 시작
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
        case .authorizedAlways:
            print("Always")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작! => didUpdateLocations 실행
        @unknown default:
            print("DEFAULT")
        }
        
        if #available(iOS 14.0, *) {
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
                
            }

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            
            let annotation = MKPointAnnotation()
            annotation.title = "CURRENT LOCATION"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        } else {
            print("Location Cannot Find")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
    
    
}


// MARK: - MKMapViewDelegate
extension TheaterLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("clicked")
    }
}
