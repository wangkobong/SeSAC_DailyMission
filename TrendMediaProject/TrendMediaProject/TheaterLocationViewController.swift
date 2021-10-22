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
        let lat = locationManager.location?.coordinate.latitude
        let long = locationManager.location?.coordinate.longitude
        self.title = ""
        print(findAddr(lat: lat ?? 0, long: long ?? 0))


        mapView.delegate = self
        locationManager.delegate = self

    }
    
    @objc func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)

    }
    
    func findAddr(lat: CLLocationDegrees, long: CLLocationDegrees) -> String{
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        var test = ""
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { placemarks, error in
            <#code#>
        }
        return ""
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
//            let alter = UIAlertController(title: "위치권한 설정이 '안함'으로 되어있습니다.", message: "앱 설정 화면으로 가시겠습니까? \n '아니오'를 선택하시면 앱이 종료됩니다.", preferredStyle: UIAlertController.Style.alert)
//            let logOkAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default){
//                (action: UIAlertAction) in
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
//                } else {
//                    UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
//                }
//            }
//            let logNoAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.destructive){
//                (action: UIAlertAction) in
//                exit(0)
//            }
//            alter.addAction(logNoAction)
//            alter.addAction(logOkAction)
//            self.present(alter, animated: true, completion: nil)
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

        if let coordinate = locations.last?.coordinate {

            let annotation = MKPointAnnotation()
            annotation.title = "CURRENT LOCATION"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)

            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)

            //10. (중요)
            locationManager.startUpdatingLocation()
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
