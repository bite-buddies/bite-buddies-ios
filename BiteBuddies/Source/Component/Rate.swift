//
//  Rate.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import SwiftUI

struct Rate: View {
    @Binding var rate: Int
    var body: some View {
        GeometryReader { geometryProxy in
            let width = geometryProxy.size.width
            let singleWidth = 23 * width / 100
            HStack(spacing: width / 50) {
                ForEach(0..<5) { idx in
                    ZStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundStyle(Color(.lightGray))
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .mask(alignment: .leading) {
                                Color.black
                                    .frame(width: {
                                        let adjustedValue = CGFloat(idx) - (CGFloat(rate) - 2) / 2 + 0.1
                                        let clampedValue = max(min(adjustedValue, 1), 0)
                                        return singleWidth * (1 - clampedValue)
                                    }())
                            }
                    }
                }
            }
            .padding(.vertical, width / 100)
            .simultaneousGesture(
                DragGesture(coordinateSpace: .local)
                    .onChanged { newValue in
                        let value = Int(round(newValue.location.x / width * 10))
                        let clampedValue = max(min(value, 10), 0)
                            rate = clampedValue
                    }
            )
        }
        .aspectRatio(5/1, contentMode: .fit)
    }
}
