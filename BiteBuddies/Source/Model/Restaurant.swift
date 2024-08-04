//
//  Marker.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import Foundation
import MapKit

struct Restaurant: Decodable, Equatable {
    
    let rest_id: Int
    let name: String
//    let imageUrl: String
    let rating: Int
//    let coordinates: Coordinate
    let address: String
    let latitude: Double
    let longitude: Double
    var value: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
