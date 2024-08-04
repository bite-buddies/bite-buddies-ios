//
//  Marker.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import Foundation
import MapKit

struct Marker: Identifiable {
    
    let id: Int
    let label: String
    let image: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
