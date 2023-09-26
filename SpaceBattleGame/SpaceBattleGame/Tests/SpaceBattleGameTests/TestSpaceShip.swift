//
//  TestSpaceShip.swift
//
//
//  Created by Mакс T on 24.09.2023.
//

@testable import SpaceBattleGame

final class TestSpaceShip: UObject {
    var properties: [String: Any]
    
    init(properties: [String : Any]) {
        self.properties = properties
    }
    
    func getProperty(key: String) throws -> Any {
        guard let value = properties[key] else {
            throw SpaceBattleGameError.getProperty(key)
        }
        return value
    }
    
    func setProperty(key: String, newValue: Any) throws {
        if properties.keys.contains(key) {
            properties[key] = newValue
        } else {
            throw SpaceBattleGameError.setProperty(key)
        }
    }
}

enum SpaceBattleGameError: Error, Equatable {
    case getProperty(String)
    case setProperty(String)
}
