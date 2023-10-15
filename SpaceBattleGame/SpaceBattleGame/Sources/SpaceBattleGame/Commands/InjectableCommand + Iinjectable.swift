//
//  InjectableCommand + Iinjectable.swift
//
//
//  Created by Mакс T on 15.10.2023.
//

import Foundation

protocol IInjectable {
    func inject(cmd: ICommand)
}

final class InjectableCommand: ICommand, IInjectable {
    private var cmd: ICommand
    
    init(cmd: ICommand) {
        self.cmd = cmd
    }
    
    func execute() throws {
        try cmd.execute()
    }
    
    func inject(cmd: ICommand) {
        self.cmd = cmd
    }
}
