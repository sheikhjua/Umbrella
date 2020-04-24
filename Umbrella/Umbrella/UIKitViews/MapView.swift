//
//  MapView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable{
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.showsUserLocation = true
//        let locationManager = CLLocationManager()
//        let status = CLLocationManager.authorizationStatus()
//        if status == .authorizedAlways || status == .authorizedWhenInUse {
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//            if let location = locationManager.location?.coordinate {
//                let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
//                let region = MKCoordinateRegion(center: location, span: span)
//                uiView.setRegion(region, animated: true)
//            }
//        } else {
//            locationManager.requestAlwaysAuthorization()
//            locationManager.requestWhenInUseAuthorization()
//        }
        
    }
    func makeCoordinator()->Coordinator{
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapView
        init(_ parent: MapView){
            self.parent = parent
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}
