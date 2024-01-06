//
//  File.swift
//  
//
//  Created by Mакс T on 03.01.2024.
//

import Foundation
import SwiftUI

final public class NavigationViewModel: ObservableObject {
    @Published public var currentScreen: Screen?
    
    var currentNavigationType: NavigationType = .push
    
    var screenStack: NavigationStack = NavigationStack() {
        didSet {
            currentScreen = screenStack.topScreen()
        }
    }
    
    private let animation: Animation
    
    public init(animation: Animation = .easeInOut) {
        self.animation = animation
    }
    
    public func push(newScreen: any View) {
        withAnimation(animation) {
            currentNavigationType = .push
            screenStack.push(
                newScreen: Screen(id: UUID().uuidString, view: AnyView(newScreen))
            )
        }
    }
    
    public func pop() {
        withAnimation(animation) {
            currentNavigationType = .pop
            screenStack.pop()
        }
    }
    
    public func popToRoot() {
        withAnimation(animation) {
            currentNavigationType = .popToRoot
            screenStack.popToRoot()
        }
    }
}
