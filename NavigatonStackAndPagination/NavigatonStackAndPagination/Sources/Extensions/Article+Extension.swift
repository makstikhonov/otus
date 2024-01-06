//
//  Article+Extension.swift
//  NavigatonStackAndPagination
//
//  Created by Mакс T on 06.01.2024.
//

import Foundation

extension Article: Identifiable {
    public var id: String { url ?? UUID().uuidString }
}
