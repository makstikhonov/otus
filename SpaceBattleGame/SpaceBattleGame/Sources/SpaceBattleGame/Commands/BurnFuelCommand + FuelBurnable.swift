//
//  BurnFuelCommand + FuelBurnable.swift
//  
//
//  Created by Mакс T on 08.10.2023.
//

import Foundation

protocol FuelBurnable {
    func getFuelLevel() throws -> Float
    func getConsumption() throws -> Float
    func setFuelLevel(_ level: Float) throws
}

final class BurnFuelCommand: ICommand {
    let m: FuelBurnable
    
    init(_ m: FuelBurnable) {
        self.m = m
    }
    
    func execute() throws {
        try m.setFuelLevel(m.getFuelLevel() - m.getConsumption())
    }
}
