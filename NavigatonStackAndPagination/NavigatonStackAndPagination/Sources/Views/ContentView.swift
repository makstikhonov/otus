//
//  ContentView.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 04.01.2024.
//

import SwiftUI
import CustomNavigation

let navigationViewModel: NavigationViewModel = NavigationViewModel()

struct ContentView: View {
    var body: some View {
        CustomNavigationView(viewModel: navigationViewModel, transition: (push: .opacity, pop: .opacity)) {
            SegmentedControlView()
        }
    }
}

#Preview {
    ContentView()
}

