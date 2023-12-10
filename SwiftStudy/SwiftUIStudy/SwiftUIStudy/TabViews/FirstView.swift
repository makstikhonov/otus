//
//  FirstView.swift
//  SwiftUIStudy
//
//  Created by Mакс T on 10.12.2023.
//

import SwiftUI

struct FirstView: View {
    @Binding var state: Tab
    @Binding var selectedListIndex: Int?
    
    var body: some View {
        VStack {
            CustomButtonView(
                didTapAction: {
                    withAnimation {
                        selectedListIndex = 1
                        state = .second
                    }
                }, text: "Custom UIKit Button"
            )
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .frame(width: 200, height: 50)
        }
    }
}
