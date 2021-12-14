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
    let theaterLocations = TheaterLocation()
    var locality = ""
    var thorughfare = ""
    
//    locality 프로퍼티 = 강남구
//
//    thorughfare = 삼성동
//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self ,action: #selector(closeButtonPressed))
 
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self ,action: #selector(filterButtonClicked))
        navigationItem.rightBarButtonItem?.title = "filter"

        mapView.delegate = self
        locationManager.delegate = self
  
    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)

    }
    
    @objc func filterButtonClicked(_ sender: Any){
        print("filter pressed")
    }
    

    @IBAction func filterTheaterPressed(_ sender: UISegmentedControl) {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        let theaterName = sender.titleForSegment(at: sender.selectedSegmentIndex)
        if theaterName == "전체" {
            let filterType = theaterLocations.theaters
            for theater in filterType {
                let annotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: theater.latitude , longitude: theater.longitude)
                let location = theater.location
                annotation.title = location
                annotation.coordinate = coordinate
                let seoul = CLLocationCoordinate2D(latitude: 37.566401502360314, longitude: 126.97795582898831)
                let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 0.5)
                let region = MKCoordinateRegion(center: seoul, span: span)
                mapView.setRegion(region, animated: true)
                mapView.addAnnotation(annotation)
            }
            
        } else {
            let filterType = theaterLocations.theaters.filter{ $0.type == theaterName }
            for theater in filterType {
                let annotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: theater.latitude , longitude: theater.longitude)
                let lacation = theater.location
                annotation.title = lacation
                annotation.coordinate = coordinate
                let seoul = CLLocationCoordinate2D(latitude: 37.566401502360314, longitude: 126.97795582898831)
                let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 0.5)
                let region = MKCoordinateRegion(center: seoul, span: span)
                mapView.setRegion(region, animated: true)
                mapView.addAnnotation(annotation)
            }
        }
     
        locationManager.startUpdatingLocation()
    }
    
    
    
    func printLocality(_ lat: CLLocationDegrees, _ long: CLLocationDegrees) -> String{
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")

        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { placemarks, error in
            let placemark: CLPlacemark? = placemarks?[0]
            self.locality = placemark?.locality ?? "고백구"
            self.thorughfare = placemark?.thoroughfare ?? "행복동"

        }
        return "\(self.locality) \(self.thorughfare)"
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
            let location = CLLocationCoordinate2D(latitude: 37.566401502360314, longitude: 126.97795582898831)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
    
            let annotaion = MKPointAnnotation()
            annotaion.title = "서울시청"
            annotaion.coordinate = location
            mapView.addAnnotation(annotaion)
            showAlert(title: "위치권한 설정을 거부하셨습니다", message: "위치 설정 화면으로 가시겠습니까?", okTitle: "설정으로 이동") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
                } else {
                    UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
                }
            }
            locationManager.startUpdatingLocation()
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
        print(#function)
            
//        theaterLocation.theaters.map { theater in
//            let annotation = MKPointAnnotation()
//            annotation.title = theater.location
//            mapView.addAnnotation(annotation)
//
//            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//            let region = MKCoordinateRegion(center: coordinate, span: span)
//            mapView.setRegion(region, animated: true)
//        }

        if let coordinate = locations.last?.coordinate {


            let annotation = MKPointAnnotation()
            annotation.title = "CURRENT LOCATION"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)

            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)

            //10. (중요)
            let result = printLocality(coordinate.latitude, coordinate.longitude)
            self.title = result

            locationManager.startUpdatingLocation()
            locationManager.stopUpdatingLocation()
        } else {
            print("Location Cannot Find")
        }
    }



    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServiceAuthorization()
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServiceAuthorization()
    }
    
    
}


// MARK: - MKMapViewDelegate
extension TheaterLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("clicked")
    }
}
