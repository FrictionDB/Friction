//
//  FrictionCLI.swift
//  CLI
//
//  Created by Arthur Guiot on 3/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class FrictionCLI {
    let console = ConsoleIO()
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
        }
    }
    func showHelp() {
        console.printUsage()
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
