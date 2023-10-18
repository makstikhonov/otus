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
    private let m: FuelCheckable
    private var exceptionCount: Int = 0
    
    init(_ m: FuelCheckable) {
        self.m = m
    }
    
    func execute() throws {
        let fuelRemaining = try m.getFuelLevel() - m.getConsumption()
        guard fuelRemaining >= 0.0 else {
            exceptionCount = exceptionCount + 1
            throw CheckFuelError.noFuelToBurn(exceptionCount)
        }
    }
}

enum CheckFuelError: Error, LocalizedError, Equatable {
    case noFuelToBurn(Int = 0)
    var errorDescription: String? {
        return "No Fuel to burn"
    }
    static func == (lhs: CheckFuelError, rhs: CheckFuelError) -> Bool {
        switch (lhs, rhs) {
        case (.noFuelToBurn(let lhsCode), .noFuelToBurn(let rhsCode)):
            return lhsCode == rhsCode
        }
    }
}
