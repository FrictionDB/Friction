
//
//  File.swift
//  CLI
//
//  Created by Arthur Guiot on 3/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class ConsoleIO {
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\(message)")
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }
    func printUsage() {
        
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("usage:")
        writeMessage("Create: \(executableName) -c <directory>")
        writeMessage("or")
        writeMessage("\(executableName) -h to show usage information")
        writeMessage("Type \(executableName) without an option to enter interactive mode.")
    }
}

enum OutputType {
    case error
    case standard
}
