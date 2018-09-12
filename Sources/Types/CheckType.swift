//
//  GetType.swift
//  Friction-iOS
//
//  Created by Arthur Guiot on 12/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class CheckType {
    private func isString(str: Any) -> Bool {
        return str is String
    }
    private func isInt(x: Any) -> Bool {
        return x is Int
    }
    private func isFloat(x: Any) -> Bool {
        return x is Float
    }
    private func isDate(x: Any) -> Bool {
        return x is Date
    }
    private func isFile(x: Any) -> Bool {
        let json = JSON(x)

        let dictionnary = json.dictionaryValue
        let keys = dictionnary.keys
        let array = Array(keys)
        let defaultF = [
            "sha256",
            "name"
        ]
        return defaultF.elementsEqual(array)
    }
    private func isJSON(x: Any) -> Bool {
        return JSON(x) is JSON
    }
}
