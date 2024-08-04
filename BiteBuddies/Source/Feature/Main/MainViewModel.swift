//
//  MainViewModel.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import CoreLocation
import SwiftUI
import MapKit

@Observable
class MainViewModel: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var location: CLLocationCoordinate2D?
    var cameraPosition: MapCameraPosition = .region(.init())
    
    var locationAllowed: Bool?
    var searchText: String = ""
    var markers: [Marker] = [
        .init(id: 1, label: "Apple Park", image: "https://picsum.photos/200/200", latitude: 37.334606, longitude: -122.009102)
    ]
    var selectedMarker: Int?
    
    override init() {
        super.init()
        manager.delegate = self
        updateLocationAllowed()
    }
    
    func selectMarker(as marker: Marker) {
        if selectedMarker == marker.id {
            selectedMarker = nil
        } else {
            if let span = cameraPosition.region?.span {
                withAnimation(.spring) {
                    cameraPosition = .region(.init(center: marker.coordinate, span: span))
                    selectedMarker = marker.id
                }
            }
        }
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func updateLocationAllowed() {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationAllowed = nil
        case .authorizedAlways:
            locationAllowed = true
            requestLocation()
        default:
            locationAllowed = false
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateLocationAllowed()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        if let location {
            cameraPosition = .region(.init(center: location, span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the user location: \(error.localizedDescription)")
    }
}
