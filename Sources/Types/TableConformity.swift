//
//  TableConformity.swift
//  Friction-iOS
//
//  Created by Arthur Guiot on 9/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class TableConformity {
    var db: URL
    init(name: URL) {
        db = name
    }
    
    private func loadIndex() throws -> JSON {
        let url = db.appendingPathComponent("index.json")
        let data = try Data(contentsOf: url)
        let json = try JSON(data: data)
        return json
    }
    private func getKeys(json: JSON) -> Array<String> {
        let dictionnary = json.dictionaryValue
        let keys = dictionnary.keys
        let array = Array(keys)
        return array
    }
    private func compareKeys(entry: JSON) -> Bool {
        do {
            let index = try loadIndex()
            let iKeys = getKeys(json: index)
            let eKeys = getKeys(json: entry)
            
            return iKeys == eKeys
        } catch {
            logw("Table conformity: error, couldn't load index")
        }
        return false
    }
}
