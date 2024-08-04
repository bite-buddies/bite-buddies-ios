//
//  ReviewViewModel.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import Foundation

@Observable
class ReviewViewModel {
    
    var menuText: String = ""
    var rate: Int = 10
    
    func post(id: Int) async {
        try! await MainService.postReview(restId: id, dishName: menuText, rate: rate)
    }
}
