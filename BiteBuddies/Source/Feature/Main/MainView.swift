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
            .zIndex(2)
            if let locationAllowed = viewModel.locationAllowed {
                if locationAllowed {
                    Map(
                        position: $viewModel.cameraPosition,
                        interactionModes: viewModel.selected == nil ? .all : []
                    ) {
                        UserAnnotation()
                        if let restaurants = viewModel.restaurants {
                            ForEach(restaurants, id: \.rest_id) { marker in
                                let isThisMarker = viewModel.selected?.rest_id == marker.rest_id
                                Annotation(
                                    marker.name,
                                    coordinate: marker.value,
                                    anchor: .bottom
                                ) {
                                    VStack(spacing: 8) {
                                        AsyncImage(url: URL(string: marker.image_url)!) {
                                            image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Color(.lightGray)
                                        }
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                        .background(
                                            ZStack {
                                                Circle()
                                                    .fill(Color.accentColor)
                                                    .frame(width: 150, height: 150)
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 130, height: 130)
                                            }
                                        )
                                        Triangle()
                                            .fill(Color.accentColor)
                                            .frame(width: 40, height: 40)
                                    }
                                    .padding(10)
                                    .scaleEffect(
                                        isThisMarker ? 1 : 0.5,
                                        anchor: .bottom
                                    )
                                    .highPriorityGesture(
                                        TapGesture()
                                            .onEnded {
                                                viewModel.selectMarker(as: marker)
                                            }
                                    )
                                    .animation(
                                        .spring,
                                        value: isThisMarker
                                    )
                                }
                            }
                        }
                    }
                    .mapStyle(.standard(pointsOfInterest: .excludingAll))
                    .mapControls {
                        if viewModel.selected == nil {
                            MapScaleView()
                            MapUserLocationButton()
                            MapCompass()
                        }
                    }
                    .mapControlVisibility(.automatic)
                    .safeAreaPadding(.top, 20)
                    .padding(.top, -20)
                    .overlay {
                        if viewModel.selected != nil {
                            Color.clear
                                .contentShape(Rectangle())
                                .simultaneousGesture(
                                    TapGesture()
                                        .onEnded {
                                            viewModel.moved()
                                        }
                                        .simultaneously(
                                            with: DragGesture()
                                                .onChanged { _ in
                                                    viewModel.moved()
                                                }
                                        )
                                        .simultaneously(
                                            with: MagnifyGesture()
                                                .onChanged { _ in
                                                    viewModel.moved()
                                                }
                                        )
                                )
                        }
                    }
                    .overlay(alignment: .bottom) {
                        if let selected = viewModel.selected {
                            Button {
                                flow.push(RestaurantView(data: selected))
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(selected.name)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(Color.black)
                                    Text(selected.address)
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color(.lightGray))
                                    HStack(spacing: 6) {
                                        Text("A friend’s rating")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(Color.gray)
                                        Rate(rate: .constant(selected.rating))
                                            .frame(height: 12)
                                        Spacer()
                                        Text("View Reviews")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(Color.accentColor)
                                    }
                                }
                                .padding(24)
                            }
                            .background(
                                ZStack {
                                    Color.white
                                        .clipShape(
                                            UnevenRoundedRectangle(
                                                cornerRadii: .init(
                                                    topLeading: 20,
                                                    topTrailing: 20
                                                )
                                            )
                                        )
                                    Color.white
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 20)
                                        )
                                        .ignoresSafeArea()
                                }
                            )
                            .transition(
                                .asymmetric(
                                    insertion: .push(from: .bottom),
                                    removal: .push(from: .top)
                                )
                            )
                        }
                    }
                } else {
                    VStack {
                        Text("Allow location to find nearby bites.")
                            .font(.system(size: 16, weight: .medium))
                        Button {
                            UIApplication.shared.open(
                                URL(string: UIApplication.openSettingsURLString)!
                            )
                        } label: {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .navigationBarHidden(true)
    }
}

#Preview {
    MainView()
}
