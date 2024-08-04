//
//  Dish.swift
//  BiteBuddies
//
//  Created by Mercen on 8/4/24.
//

import SwiftUI

struct Dish: View {
    
    let selected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: "https://picsum.photos/500/300")!) {
                image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color(.lightGray)
            }
            .frame(width: 85, height: 50)
            .overlay {
                if selected {
                    ZStack {
                        Color.accentColor
                            .opacity(0.4)
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 4) {
                Text("Chick-fil-A")
                    .font(.system(size: 16, weight: .semibold))
                HStack(spacing: 6) {
                    Text("Average Rate")
                        .font(.system(size: 14))
                    Rate(rate: .constant(8))
                        .frame(height: 12.6)
                }
            }
        }
    }
}
