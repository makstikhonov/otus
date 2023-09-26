//
//  File.swift
//  
//
//  Created by Mакс T on 24.09.2023.
//

import Foundation

protocol UObject {
    func getProperty(key: String) throws -> Any
    func setProperty(key: String, newValue: Any) throws
}
