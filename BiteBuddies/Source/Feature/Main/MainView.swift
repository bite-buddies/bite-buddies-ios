//
//  MainView.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import SwiftUI
import MapKit

struct MainView: View {
    @Bindable var viewModel = MainViewModel()
    @Flow var flow
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(.buddy)
                        .resizable()
                        .frame(width: 25, height: 23)
                    Image(.textLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
                .foregroundStyle(Color.white)
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color.accentColor)
                    TextField(
                        "Find your nearby BITES!",
                        text: $viewModel.searchText
                    )
                    .font(.system(size: 14))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 2))
            }
            .padding(24)
            .background(
                ZStack {
                    Color.accentColor
                        .clipShape(
                            UnevenRoundedRectangle(
                                cornerRadii: .init(
                                    bottomLeading: 20,
                                    bottomTrailing: 20
                                )
                            )
                        )
                    Color.accentColor
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                        .ignoresSafeArea()
                }
            )
            .zIndex(1)
            if let locationAllowed = viewModel.locationAllowed {
                if locationAllowed {
                    Map(
                        position: $viewModel.cameraPosition,
                        interactionModes: .all
                    ) {
                        UserAnnotation()
                        ForEach(viewModel.markers) { marker in
                            Annotation(
                                marker.label,
                                coordinate: marker.coordinate,
                                anchor: .bottom
                            ) {
                                Button {
                                    viewModel.selectMarker(as: marker)
                                } label: {
                                    VStack(spacing: 8) {
                                        AsyncImage(url: URL(string: marker.image)!) {
                                            image in
                                            image
                                                .resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                        .background(
                                            ZStack {
                                                Circle()
                                                    .fill(Color.accentColor)
                                                    .frame(width: 95, height: 95)
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 83, height: 83)
                                            }
                                        )
                                        Triangle()
                                            .fill(Color.accentColor)
                                            .frame(width: 25, height: 25)
                                    }
                                }
                                .padding(10)
                            }
                        }
                    }
                    .mapStyle(.standard(pointsOfInterest: .excludingAll))
                    .mapControls {
                        MapScaleView()
                        MapUserLocationButton()
                        MapCompass()
                    }
                    .mapControlVisibility(.automatic)
                    .safeAreaPadding(.top, 20)
                    .padding(.top, -20)
                } else {
                    Button {
                        UIApplication.shared.open(
                            URL(string: UIApplication.openSettingsURLString)!
                        )
                    } label: {
                        Text("Allow location")
                            .frame(maxHeight: .infinity)
                    }
                }
            } else {
                Spacer()
            }
        }
        .simultaneousGesture(
            DragGesture()
                .onChanged { _ in
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                }
        )
        .onAppear {
            viewModel.manager.requestAlwaysAuthorization()
        }
    }
}

#Preview {
    MainView()
}
