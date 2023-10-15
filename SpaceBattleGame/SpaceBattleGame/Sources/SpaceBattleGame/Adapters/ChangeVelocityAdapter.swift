//
//  File.swift
//  
//
//  Created by Mакс T on 08.10.2023.
//

import Foundation

final class ChangeVelocityAdapter {
    let o: UObject
    init(o: UObject) {
        self.o = o
    }
}

extension ChangeVelocityAdapter: VelocityChangeable {
    func getVelocity() throws -> Vector2D {
        try o.getProperty(key: "Velocity") as! Vector2D
    }
    
    func setVelocity(_ velocity: Vector2D) throws {
        try o.setProperty(key: "Velocity", newValue: velocity)
    }
}

