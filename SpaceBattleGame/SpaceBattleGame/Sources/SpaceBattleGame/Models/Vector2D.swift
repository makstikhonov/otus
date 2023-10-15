//
//  Vector2D.swift
//  
//
//  Created by Mакс T on 24.09.2023.
//

import Foundation

struct Vector2D: Equatable {
    let x: Float
    let y: Float
    
    static func +(left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func -(left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x - right.x, y: left.y - right.y)
    }
}
