//
//  ThirdView.swift
//  SwiftUIStudy
//
//  Created by Mакс T on 10.12.2023.
//

import SwiftUI

struct ThirdView: View {
    @Binding var isModalShown: Bool
    
    var body: some View {
        Button {
            isModalShown = true
        } label: {
            ZStack {
                Text("Open Modal")
                    .padding(10.0)
                    .accentColor(.white)
                    .background(RoundedRectangle(cornerRadius: 10.0))
            }
        }
    }
}

