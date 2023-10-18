//
//  ExceptionLog + ExceptionLoggable + Logger.swift
//
//
//  Created by Mакс T on 15.10.2023.
//

import Foundation

protocol ExceptionLoggable {
    func logException(_ exception: Error)
}

final class ExceptionLogCommand: ICommand {
    let loggable: ExceptionLoggable
    let exception: Error
    
    init(loggable: ExceptionLoggable, exception: Error) {
        self.loggable = loggable
        self.exception = exception
    }
    
    func execute() throws {
        loggable.logException(exception)
    }
}

final class Logger: ExceptionLoggable {
    func logException(_ exception: Error) {
        print("Exception occurred: \(exception)")
    }
}
