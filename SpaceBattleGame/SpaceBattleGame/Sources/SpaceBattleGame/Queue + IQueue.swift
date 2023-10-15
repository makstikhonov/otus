//
//  Queue + IQueue.swift
//
//
//  Created by Mакс T on 15.10.2023.
//

import Foundation

protocol IQueue {
    func put(_ command: ICommand)
    func take() -> ICommand
}

final class Queue: IQueue {
    private var commands: [ICommand] = []
    private let queue = DispatchQueue(label: "commands.queue", attributes: .concurrent)
    var isEmpty: Bool {
        queue.sync {
            return commands.isEmpty
        }
    }
    
    func put(_ command: ICommand) {
        queue.async(flags: .barrier) {
            self.commands.append(command)
        }
    }
    
    func take() -> ICommand {
        return queue.sync {
            commands.removeFirst()
        }
    }
}

