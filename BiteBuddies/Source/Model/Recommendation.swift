//
//  Recommendation.swift
//  BiteBuddies
//
//  Created by Mercen on 8/4/24.
//

import Foundation

struct Recommendation: Decodable, Hashable {
    
    let dish_tried: String
    let rating: Int
}
