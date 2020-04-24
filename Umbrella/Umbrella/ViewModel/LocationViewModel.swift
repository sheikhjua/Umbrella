//
//  LocationViewModel.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 23/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject{
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    
    private let locationManager = CLLocationManager()
    
    override init(){
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.distanceFilter = 10
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.allowsBackgroundLocationUpdates = true
    }
    func requestLocationPermission(){
        self.locationManager.requestAlwaysAuthorization()
    }
}
extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        let authManager = FirebaseAuthManager.shared
        if let userID = authManager.currentUserProfile.userID, !userID.isEmpty {
            authManager.updateLocation(forUser: userID, location: location) { (result) in
                switch result{
                case .success(_): break
                case .failure(let error):
                    print("Error saving location: \(error.localizedDescription)")
                }
            }
        }
        print("Current location: \(location)")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            UserDefaults.standard.setLocationPermission(status: false)
        case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
            UserDefaults.standard.setLocationPermission(status: true)
        @unknown default:
            fatalError()
        }
    }
}
