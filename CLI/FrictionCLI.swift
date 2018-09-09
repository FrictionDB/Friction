//
//  FrictionCLI.swift
//  CLI
//
//  Created by Arthur Guiot on 3/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation
import Friction

class FrictionCLI {
    let console = ConsoleIO()
    let friction = Friction()
    func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    func dynamic() {
        if CommandLine.argc < 2 {
            showHelp()
            return
        }
        var arg = CommandLine.arguments[1]
        arg = arg.substring(from: arg.index(arg.startIndex, offsetBy: 1)) // remove "-"
        if getOption(arg).option == .help {
            showHelp()
            return
        } else if getOption(arg).option == .create && CommandLine.argc > 2 {
            let path = CommandLine.arguments[2]
            createDB(arg: path)
            return
        }
        showHelp()
    }
    func showHelp() {
        console.printUsage()
    }
    func createDB(arg: String) {
        let location = NSString(string: arg).expandingTildeInPath
        let path = URL(string: location)!
        console.writeMessage("Creating DB in \(path.absoluteString)")
        friction.createDB(path: path, backup: nil)
    }
}

enum OptionType: String {
    case create = "c"
    case help = "h"
    case unknown
    
    init(value: String) {
        switch value {
        case "c": self = .create
        case "h": self = .help
        default: self = .unknown
        }
    }
}
