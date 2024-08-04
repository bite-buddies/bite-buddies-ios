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
                    VStack(alignment: .leading) {
                        Text("Rating")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.accentColor)
                        Rate(rate: $viewModel.rate)
                            .frame(height: 33)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                }
            }
            .scrollIndicators(.never)
            .safeAreaPadding(.top, 53)
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
                Button {
                    
                } label: {
                    Text("Submit")
                        .font(.system(size: 20, weight: .medium))
                        .padding(.vertical, 15)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.bottom, 12)
                .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    FlowPreview {
        ReviewView()
    }
}
