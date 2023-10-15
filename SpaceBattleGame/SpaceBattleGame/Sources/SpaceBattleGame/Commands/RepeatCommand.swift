//
//  RepeatCommand.swift
//
//
//  Created by Mакс T on 15.10.2023.
//

import Foundation

final class RepeatCommand: ICommand {
    let queue: IQueue
    let command: ICommand
    
    init(queue: IQueue, command: ICommand) {
        self.queue = queue
        self.command = command
    }
    
    func execute() throws {
        queue.put(command)
    }
}
