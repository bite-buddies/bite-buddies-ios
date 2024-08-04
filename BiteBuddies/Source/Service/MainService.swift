//
//  MainService.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import Foundation
import Alamofire

struct MainService {
    
    static let ENDPOINT = "http://localhost:8080"
    
    static func fetchRestaurants() async throws -> [Restaurant] {
        try await AF.request(
            "\(ENDPOINT)/restaurants/list",
            method: .get
        )
        .validate()
        .serializingDecodable([Restaurant].self)
        .value
    }
}
