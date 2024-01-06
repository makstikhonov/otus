//
//  NavigationTypes.swift
//
//
//  Created by Mакс T on 03.01.2024.
//

import Foundation
import SwiftUI

public enum NavigationType {
    case push
    case pop
    case popToRoot
}

public enum TransitionType {
    case none
    case custom(AnyTransition)
}
