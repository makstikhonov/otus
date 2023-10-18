//
//  ExceptionHandler.swift
//
//
//  Created by Mакс T on 15.10.2023.
//

import Foundation

final class ExceptionHandler {
    var store: [String: [String: (ICommand, Error) -> ICommand]] = [:]
    
    func handle(e: Error, cmd: ICommand) -> ICommand {
        let et = "\(type(of: e)).\(e.self)"
        let ct = "\(type(of: cmd))"
        return store[ct]?[et]?(cmd, e) ?? cmd
    }
}
