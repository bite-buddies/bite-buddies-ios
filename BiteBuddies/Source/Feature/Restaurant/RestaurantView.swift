//
//  RestaurantView.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import SwiftUI

struct RestaurantView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var statusBarCovered: Bool = false
    
    @Flow var flow
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
                    .frame(height: 257)
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
                    .frame(width: outsideProxy.size.width)
                    .clipped()
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
                .background(
                    GeometryReader { insideProxy in
                        let yCoordinate = insideProxy.frame(in: .global).minY
                        Color.clear
                            .onChange(of: yCoordinate) {
                                let margin = outsideProxy.safeAreaInsets.top + 54
                                statusBarCovered = yCoordinate < -257 + margin
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
    }
}

#Preview {
    FlowPreview {
        RestaurantView()
    }
}
