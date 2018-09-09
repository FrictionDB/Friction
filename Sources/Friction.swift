//
//  Friction.swift
//  FrictionDB
//
//  Created by Arthur Guiot on 02/09/2018.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class Friction {
    func createDB(path: URL, backup: JSON?) {
        let manager = CreateDB(url: path, backup: backup)
        manager.create()
    }
}

extension Friction {
    var version: String {
        return "0.1.0"
    }
}
