//
//  ReviewView.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import SwiftUI

struct ReviewView: View {
    
    let data: Restaurant
    
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel = ReviewViewModel()
    @FocusState var focused: Bool
    
    @Flow var flow
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 0) {
                    Info(
                        name: data.name,
                        rate: data.rating,
                        location: data.address
                    )
                    Rectangle()
                        .fill(Color(.lightGray))
                        .frame(height: 1)
                        .opacity(0.5)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("View Reviews")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.accentColor)
                        TextField("Enter dish name", text: $viewModel.menuText)
                            .font(.system(size: 16))
                            .focused($focused)
                        Rectangle()
                            .fill(focused ? Color.accentColor : Color.gray)
                            .frame(height: 1)
                    }
                    .padding(24)
                }
            }
            .scrollIndicators(.never)
            .scrollDismissesKeyboard(.interactively)
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
                        Task {
                            await viewModel.post(id: data.rest_id)
                            flow.pop()
                            flow.reload()
                        }
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
