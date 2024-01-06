//
//  CustomNavigationView.swift
//
//
//  Created by Mакс T on 03.01.2024.
//

import SwiftUI

public struct CustomNavigationView<Content: View>: View {
    @ObservedObject var viewModel: NavigationViewModel
    
    private let content: Content
    private let animation: Animation = .easeIn
    private let transition: (push: AnyTransition, pop: AnyTransition)
    
    public init(
        viewModel: NavigationViewModel,
        transition: (push: AnyTransition, pop: AnyTransition),
        contentBuilder: @escaping () -> Content
    ) {
        self.viewModel = viewModel
        self.content = contentBuilder()
        self.transition = transition
    }
    
    public var body: some View {
        let isRoot: Bool = viewModel.currentScreen == nil
        ZStack {
            if isRoot {
                content
                    .environmentObject(viewModel)
                    .transition(viewModel.currentNavigationType == .push ? transition.push : transition.pop)
            } else {
                viewModel.currentScreen?.view
                    .environmentObject(viewModel)
                    .transition(viewModel.currentNavigationType == .push ? transition.push : transition.pop)
            }
        }
    }
}
