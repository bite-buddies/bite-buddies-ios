//
//  RestaurantView.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import SwiftUI

struct RestaurantView: View {
    
    let data: Restaurant
    
    @Environment(\.dismiss) var dismiss
    @State private var statusBarCovered: Bool = false
    @State private var titleCovered: Bool = false
    @State private var topMargin: CGFloat = 0
    
    @Flow var flow
    @Bindable var viewModel = RestaurantViewModel()
    
    var body: some View {
        GeometryReader { outsideProxy in
            ScrollView {
                VStack(spacing: 0) {
                    AsyncImage(url: URL(string: "https://picsum.photos/500/300")!) {
                        image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color(.lightGray)
                    }
                    .frame(
                        width: outsideProxy.size.width,
                        height: 257 + (viewModel.sheetPresented ? 0 : topMargin)
                    )
                    .overlay {
                        LinearGradient(
                            colors: [
                                .black.opacity(0.5),
                                .clear
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                    .clipped()
                    .padding(.top, (viewModel.sheetPresented ? 0 : -topMargin))
                    Info(
                        name: data.name,
                        rate: data.rating,
                        location: data.address
                    )
                    Rectangle()
                        .fill(Color(.lightGray))
                        .frame(height: 1)
                        .opacity(0.5)
                }
                .background(
                    GeometryReader { insideProxy in
                        let yCoordinate = insideProxy.frame(in: .global).minY
                        Color.clear
                            .onChange(of: yCoordinate) {
                                let margin = outsideProxy.safeAreaInsets.top + 54
                                statusBarCovered = yCoordinate < -257 + margin
                                withAnimation(.spring(duration: 0.2)) {
                                    titleCovered = yCoordinate < -303 + margin
                                }
                                topMargin = max(yCoordinate, 0)
                            }
                    }
                )
            }
            .ignoresSafeArea(edges: .top)
            .safeAreaInset(edge: .top) {
                VStack(spacing: 0) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 23)
                                .padding(5)
                        }
                        Spacer()
                        Button {
                            flow.push(ReviewView())
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26)
                                .padding(2)
                        }
                    }
                    .padding(.horizontal, 19)
                    .padding(.vertical, 12)
                    .foregroundStyle(statusBarCovered ? Color.black : .white)
                    .background(statusBarCovered ? AnyShapeStyle(.bar) : .init(Color.clear))
                    .overlay {
                        if titleCovered {
                            HStack(spacing: 4) {
                                Text(data.name)
                                    .font(.system(size: 18, weight: .semibold))
                                Image(systemName: "checkmark.seal.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                    if statusBarCovered {
                        Rectangle()
                            .fill(Color(.lightGray))
                            .frame(height: 1)
                            .opacity(0.5)
                    }
                }
            }
            .scrollIndicators(.never)
            .navigationBarHidden(true)
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.sheetPresented = true
            } label: {
                Image(.robot)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 39, height: 39)
                    .foregroundStyle(Color.white)
                    .frame(width: 70, height: 70)
                    .background(Color.accentColor)
            }
            .clipShape(Circle())
            .padding(11)
        }
        .sheet(isPresented: $viewModel.sheetPresented) {
            VStack(spacing: 0) {
                Capsule()
                    .fill(Color.black)
                    .frame(width: 108, height: 4)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                VStack(alignment: .leading, spacing: 2) {
                    Image(.robot)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 36.7)
                        .foregroundStyle(Color.accentColor)
                    Text("BuddyBot's\nRecommendation")
                        .font(.system(size: 20, weight: .semibold))
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(40)
            }
        }
    }
}
