//
//  PasswordChecker.swift
//  Friction-iOS
//
//  Created by Arthur Guiot on 8/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class PasswordChecker {
    var passwordJSON: String
    init(json: String) {
        passwordJSON = json
    }
    func check(psswd: String) {
        let sha256 = psswd.sha256
        return sha256 == passwordJSON
    }
}
