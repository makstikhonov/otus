//
//  MovableAdapter.swift
//  
//
//  Created by Mакс T on 24.09.2023.
//

import Foundation

final class MovableAdapter {
    let o: UObject
    init(o: UObject) {
        self.o = o
    }
}

extension MovableAdapter: Movable {
    func getPosition() throws -> Vector2D {
        try o.getProperty(key: MovablePropertyKey.position.rawValue) as! Vector2D
    }
    
    func getVelocity() throws -> Vector2D {
        try o.getProperty(key: MovablePropertyKey.velocity.rawValue) as! Vector2D
    }
    
    func setPosition(_ position: Vector2D) throws {
        try o.setProperty(key: MovablePropertyKey.position.rawValue, newValue: position)
    }
}

enum MovablePropertyKey: String {
    case position = "Position"
    case velocity = "Velocity"
}
