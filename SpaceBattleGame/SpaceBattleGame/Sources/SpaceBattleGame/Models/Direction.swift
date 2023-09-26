//
//  Direction.swift
//
//
//  Created by Mакс T on 24.09.2023.
//

import Foundation

struct Direction: Equatable {
    let number: Int
    let directionsNumber: Int = 4
    
    func next(_ angularVelocity: Int) -> Direction {
        return Direction(number: (number + angularVelocity) % directionsNumber)
    }
    
    static func - (lhs: Direction, rhs: Direction) -> Direction {
        return Direction(number: lhs.number - rhs.number)
    }
    static func + (lhs: Direction, rhs: Direction) -> Direction {
        return Direction(number: lhs.number + rhs.number)
    }
}
