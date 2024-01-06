//
//  File.swift
//  
//
//  Created by Mакс T on 03.01.2024.
//

import Foundation

struct NavigationStack {
    private var screens: [Screen] = []
    
    func topScreen() -> Screen? {
        return screens.last
    }
    
    mutating func push(newScreen: Screen) {
        screens.append(newScreen)
    }
    
    mutating func pop() {
        screens.removeLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}
