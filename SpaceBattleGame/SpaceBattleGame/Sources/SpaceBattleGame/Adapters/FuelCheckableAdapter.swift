//
//  File.swift
//  
//
//  Created by Mакс T on 08.10.2023.
//

import Foundation

final class FuelCheckableAdapter {
    let o: UObject
    init(o: UObject) {
        self.o = o
    }
}

extension FuelCheckableAdapter: FuelCheckable {
    func getConsumption() throws -> Float {
        try o.getProperty(key: "FuelConsumption") as! Float
    }
    
    func getFuelLevel() throws -> Float {
        try o.getProperty(key: "FuelLevel") as! Float
    }
}
