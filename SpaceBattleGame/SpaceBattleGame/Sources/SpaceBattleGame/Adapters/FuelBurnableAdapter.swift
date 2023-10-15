//
//  FuelBurnableAdapter.swift
//
//
//  Created by Mакс T on 08.10.2023.
//

import Foundation

final class FuelBurnableAdapter {
    let o: UObject
    init(o: UObject) {
        self.o = o
    }
}

extension FuelBurnableAdapter: FuelBurnable {
    func getFuelLevel() throws -> Float {
        try o.getProperty(key: "FuelLevel") as! Float
    }
    
    func getConsumption() throws -> Float {
        try o.getProperty(key: "FuelConsumption") as! Float
    }
    
    func setFuelLevel(_ level: Float) throws {
        try o.setProperty(key: "FuelLevel", newValue: level)
    }
}

