//
//  RestaurantViewModel.swift
//  BiteBuddies
//
//  Created by Mercen on 8/4/24.
//

import Foundation

@Observable
class RestaurantViewModel {
    
    var sheetPresented: Bool = false
    var reviews: [Review]?
    var recommendations: [Recommendation]?
    
    func onAppear(id: Int) async {
//        reviews = try! await MainService.fetchReviews(id: id)
        reviews = Constants.reviews["\(id)"]
        await fetchRecommendations(id: id)
    }
    
    func fetchRecommendations(id: Int) async {
        recommendations = Constants.recommendations["\(id)"]
//        recommendations = try! await MainService.fetchRecommendations(id: id)
    }
}
