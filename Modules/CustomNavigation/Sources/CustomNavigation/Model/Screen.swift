//
//  File.swift
//  
//
//  Created by Mакс T on 03.01.2024.
//

import Foundation
import SwiftUI

public struct Screen: Equatable {
    public static func == (lhs: Screen, rhs: Screen) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let view: AnyView
}
