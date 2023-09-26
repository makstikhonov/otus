//
//  Move.swift
//
//
//  Created by Mакс T on 24.09.2023.
//

import Foundation

protocol Movable {
    func getPosition() throws -> Vector2D
    func getVelocity() throws -> Vector2D
    func setPosition(_ position: Vector2D) throws
}

final class Move {
    let m: Movable
    
    init(_ m: Movable) {
        self.m = m
    }
    
    func execute() throws {
        try m.setPosition(m.getVelocity() + m.getPosition())
    }
}
