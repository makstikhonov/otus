//
//  CheckFuelCommand.swift
//
//
//  Created by Mакс T on 08.10.2023.
//

import Foundation

protocol FuelCheckable {
    func getFuelLevel() throws -> Float
    func getConsumption() throws -> Float
}

final class CheckFuelCommand: ICommand {
    let m: FuelCheckable
    
    init(_ m: FuelCheckable) {
        self.m = m
    }
    
    func execute() throws {
        let fuelRemaining = try m.getFuelLevel() - m.getConsumption()
        guard fuelRemaining >= 0.0 else {
            throw CheckFuelError.noFuelToBurn
        }
    }
}

enum CheckFuelError: Error, LocalizedError {
    case noFuelToBurn
    var errorDescription: String? {
        return "No Fuel to burn"
    }
}
