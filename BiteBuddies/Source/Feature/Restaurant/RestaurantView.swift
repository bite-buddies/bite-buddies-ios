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
                    VStack(spacing: 4) {
                        HStack(spacing: 8) {
                            Text("Chick-fil-a")
                                .font(.system(size: 24, weight: .semibold))
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(Color.accentColor)
                        }
                        HStack(spacing: 8) {
                            Text("Average Rate")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color.gray)
                            Rate(rate: .constant(8))
                                .frame(height: 16)
                        }
                        Text("550 W El Camino Real, Sunnyvale, CA 94087")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(.lightGray))
                    }
                    .padding(.vertical, 24)
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
                                let margin = outsideProxy.safeAreaInsets.top + 46
                                withAnimation {
                                    statusBarCovered = yCoordinate < -257 + margin
                                }
                            }
                    }
                )
            }
            .ignoresSafeArea(edges: .top)
            .safeAreaInset(edge: .top) {
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
                        
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26)
                            .padding(2)
                    }
                }
                .padding(.horizontal, 19)
                .padding(.vertical, 8)
                .foregroundStyle(statusBarCovered ? Color.black : .white)
                .background(statusBarCovered ? AnyShapeStyle(.bar) : .init(Color.clear))
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
