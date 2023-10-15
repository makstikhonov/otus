//
//  RotableAdapter.swift
//  
//
//  Created by Mакс T on 24.09.2023.
//

import Foundation

final class RotableAdapter {
    let o: UObject
    init(o: UObject) {
        self.o = o
    }
}

extension RotableAdapter: Rotable {
    func getDirection() throws -> Direction {
        try o.getProperty(key: RotablePropertyKey.direction.rawValue) as! Direction
    }
    
    func getAngularVelocity() throws -> Int {
        try o.getProperty(key: RotablePropertyKey.angularVelocity.rawValue) as! Int
    }
    
    func setDirection(_ newDirection: Direction) throws {
        try o.setProperty(key: RotablePropertyKey.direction.rawValue, newValue: newDirection)
    }
}

enum RotablePropertyKey: String {
    case direction = "Direction"
    case angularVelocity = "AngularVelocity"
}
