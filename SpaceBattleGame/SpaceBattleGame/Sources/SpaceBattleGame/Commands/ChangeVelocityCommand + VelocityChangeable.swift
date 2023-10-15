//
//  ChangeVelocityCommand + VelocityChangeable.swift
//  
//
//  Created by Mакс T on 08.10.2023.
//

import Foundation

protocol VelocityChangeable {
    func getVelocity() throws -> Vector2D
    func setVelocity(_ velocity: Vector2D) throws
}

final class ChangeVelocityCommand: ICommand {
    let m: VelocityChangeable
    
    init(_ m: VelocityChangeable) {
        self.m = m
    }
    
    func execute() throws {
        try m.setVelocity(m.getVelocity())
    }
}

