//
//  Rotate.swift
//
//
//  Created by Mакс T on 24.09.2023.
//

import Foundation

protocol Rotable {
    func getDirection() throws -> Direction
    func getAngularVelocity() throws -> Int
    func setDirection(_ newDirection: Direction) throws
}

final class Rotate {
    let r: Rotable
    
    init(_ r: Rotable) {
        self.r = r
    }
    
    func execute() throws {
        try r.setDirection(
            try r.getDirection().next(try r.getAngularVelocity())
        )
    }
}
