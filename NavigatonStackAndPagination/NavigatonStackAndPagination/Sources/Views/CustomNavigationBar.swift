//
//  CustomNavigationBar.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 06.01.2024.
//

import Foundation
import SwiftUI

struct CustomNavigationBar: View {
    var backAction: (() -> Void)?
    
    var body: some View {
        HStack {
            Button("Back") {
                backAction?()
            }
            Spacer()
        }
        .frame(height: 50, alignment: .top)
        .padding(.all, 10)
    }
}
