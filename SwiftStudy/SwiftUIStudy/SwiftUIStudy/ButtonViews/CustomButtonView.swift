//
//  CustomButtonView.swift
//  SwiftUIStudy
//
//  Created by Mакс T on 10.12.2023.
//

import SwiftUI

struct CustomButtonView: UIViewRepresentable {
    
    let didTapAction: (() -> Void)?
    let text: String
    
    func makeUIView(context: Context) -> ButtonView {
        let view = ButtonView()
        return view
    }
    
    func updateUIView(_ uiView: ButtonView, context: Context) {
        uiView.text = text
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(didTapAction: didTapAction)
    }
}

extension CustomButtonView {
    class Coordinator: NSObject, ButtonViewDelegate {
        private var didTapAction: (() -> Void)?
        
        init(didTapAction: (() -> Void)?) {
            self.didTapAction = didTapAction
        }
        
        func didButtonTap() {
            didTapAction?()
        }
    }
}
