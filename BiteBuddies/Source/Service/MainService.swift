//
//  MainService.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import Foundation
import Alamofire

struct Empty: Decodable { }

struct MainService {
    
    static let ENDPOINT = "http://169.254.62.156:5006"
    
//    static func fetchRestaurants(
//        latitude: CGFloat,
//        longitude: CGFloat
//    ) async throws -> [Restaurant] {
//        try await AF.request(
//            "\(ENDPOINT)/get_restaurants",
//            method: .get,
//            parameters: [
//                "latitude": latitude,
//                "longitude": longitude
//            ],
//            encoding: URLEncoding.default
//        )
//        .validate()
//        .serializingDecodable([Restaurant].self)
//        .value
//    }
//    
//    static func fetchReviews(id: Int) async throws -> [Review] {
//        try await AF.request(
//            "\(ENDPOINT)/get_reviews",
//            method: .get,
//            parameters: [
//                "user_id": 1,
//                "rest_id": id
//            ],
//            encoding: URLEncoding.default
//        )
//        .validate()
//        .serializingDecodable([Review].self)
//        .value
//    }
//    
//    static func fetchRecommendations(id: Int) async throws -> [Recommendation] {
//        try await AF.request(
//            "\(ENDPOINT)/get_recommendations",
//            method: .get,
//            parameters: [
//                "user_id": 1,
//                "rest_id": id
//            ],
//            encoding: URLEncoding.default
//        )
//        .validate()
//        .serializingDecodable([Recommendation].self)
//        .value
//    }
//    
//    static func postReview(
//        restId: Int,
//        dishName: String,
//        rate: Int
//    ) async throws {
//        _ = try await AF.request(
//            "\(ENDPOINT)/post_review?buddy_id=1&rest_id=\(restId)&dish_name=\(dishName)&rating=\(rate)",
//            method: .post,
//            encoding: URLEncoding.default
//        )
//        .validate()
//        .serializingDecodable(Empty.self)
//        .value
//    }
}
