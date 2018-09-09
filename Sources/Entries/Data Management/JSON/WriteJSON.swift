//
//  WriteJSON.swift
//  Friction-iOS
//
//  Created by Arthur Guiot on 9/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class WriteJSON {
    var file: URL
    private var load: LoadJSON
    
    init(file: URL) {
        self.file = file
        self.load = LoadJSON(file: self.file)
    }
    
    private func write(json: JSON) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let data = try json.rawData()
                try data.write(to: self.file)
            } catch {
                logw("WriteJSON: Data error")
            }
        }
    }
    private func append(json: JSON) -> [JSON] {
        var finalJSON = [JSON]()
        load.readFile { (array) in
            finalJSON = array as! [JSON]
        }
        finalJSON.append(json)
        return finalJSON
    }
    
    func addEntry(json: JSON) {
        let data = JSON(arrayLiteral: append(json: json))
        write(json: data)
    }
}
