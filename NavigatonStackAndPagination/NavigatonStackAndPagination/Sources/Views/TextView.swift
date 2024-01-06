//
//  TextView.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 06.01.2024.
//

import SwiftUI
import CustomNavigation

struct TextView: View {
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    var text: String
    
    var body: some View {
        VStack {
            CustomNavigationBar {
                navigationViewModel.pop()
            }
            
            Text(text)
                .padding(.all, 10.0)
            
            Spacer()
        }
    }
}
