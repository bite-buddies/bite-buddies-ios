//
//  Coordinate.swift
//  BiteBuddies
//
//  Created by Mercen on 8/4/24.
//

import CoreLocation

struct Coordinate: Decodable {
    
    let latitude: Double
    let longitude: Double
    var value: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
