//
//  MacroCommand.swift
//  
//
//  Created by Mакс T on 08.10.2023.
//

import Foundation

final class MacroCommand: ICommand {
    let commands: [ICommand]
    
    init(commands: [ICommand]) {
        self.commands = commands
    }
    
    func execute() throws {
        for command in commands {
            try command.execute()
        }
    }
}

