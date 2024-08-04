//
//  AppMain.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import SwiftUI
import FlowKit

struct Constants {
    static func json<T: Decodable>(from name: String, to type: T.Type) -> T {
        let decoder = JSONDecoder()
        let path = Bundle.main.path(forResource: name, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        return try! decoder.decode(T.self, from: data)
    }
    
    static let restaurants = json(from: "restaurants", to: [Restaurant].self)
    static let reviews = json(from: "reviews", to: [String: [Review]].self)
    static let recommendations = json(from: "recommendations", to: [String: [Recommendation]].self)
}

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

@propertyWrapper
public struct Flow: DynamicProperty {
    
    @EnvironmentObject private var object: FlowProvider
    
    public var wrappedValue: FlowProvider {
        object
    }
    
    public init() { }
}

public struct FlowPreview<C: View>: View {
    
    private let content: () -> C
    
    public init(@ViewBuilder content: @escaping () -> C) {
        self.content = content
    }
    
    public var body: some View {
        FlowPresenter(rootView: content())
            .ignoresSafeArea()
    }
}

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
            FlowPresenter(rootView: MainView())
                .ignoresSafeArea()
        }
    }
}
