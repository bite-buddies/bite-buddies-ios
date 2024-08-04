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
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var locationAllowed: Bool?
    var searchText: String = ""
    var restaurants: [Restaurant]?
    var selected: Restaurant?
    
    override init() {
        super.init()
        manager.delegate = self
        updateLocationAllowed()
    }
    
    func onAppear() async {
        if let location {
            restaurants = try! await MainService.fetchRestaurants(
                latitude: location.latitude,
                longitude: location.longitude
            )
        }
    }
    
    func selectMarker(as marker: Restaurant) {
        withAnimation(.spring(duration: 0.3)) {
            if selected == marker {
                selected = nil
            } else {
                selected = marker
                cameraPosition = .region(
                    .init(
                        center: marker.value,
                        span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                )
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
        case .authorizedWhenInUse, .authorizedAlways:
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
        Task {
            await onAppear()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the user location: \(error.localizedDescription)")
    }
    
    func moved() {
        withAnimation(.spring(duration: 0.3)) {
            selected = nil
        }
    }
}
