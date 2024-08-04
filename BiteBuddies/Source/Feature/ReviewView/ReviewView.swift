//
//  ReviewView.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import SwiftUI

struct ReviewView: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel = ReviewViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 0) {
                    Info(
                        name: "Chick-fil-a",
                        rate: 8,
                        location: "550 W El Camino Real, Sunnyvale, CA 94087"
                    )
                    Rectangle()
                        .fill(Color(.lightGray))
                        .frame(height: 1)
                        .opacity(0.5)
                }
            }
            .scrollIndicators(.never)
            .safeAreaPadding(.top, 53)
            .safeAreaPadding(.bottom, 68)
            VStack(spacing: 0) {
                HStack(spacing: 14) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23)
                            .padding(5)
                    }
                    Text("Review")
                        .font(.system(size: 24, weight: .semibold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.black)
                .padding(.horizontal, 19)
                .padding(.vertical, 12)
                .background(.bar)
                Rectangle()
                    .fill(Color(.lightGray))
                    .frame(height: 1)
                    .opacity(0.5)
                Spacer()
                Rectangle()
                    .fill(Color(.lightGray))
                    .frame(height: 1)
                    .opacity(0.5)
                HStack(spacing: 8) {
                    Text("Rate")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.accentColor)
                    Rate(rate: $viewModel.rate)
                        .frame(height: 30)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Submit")
                            .font(.system(size: 20, weight: .medium))
                            .padding(.vertical, 10)
                            .foregroundStyle(Color.white)
                            .frame(width: 130)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(.bar)
            }
        }
    }
}

#Preview {
    FlowPreview {
        ReviewView()
    }
}
