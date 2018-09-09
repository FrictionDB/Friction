//
//  CreateDB.swift
//  Friction-iOS
//
//  Created by Arthur Guiot on 9/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class CreateDB {
    var path: URL
    var backup: JSON?
    init (url: URL, backup: JSON?) {
        path = url
        self.backup = backup
    }
    
    let fm = FileManager.default
    
    private func createDir(path: URL) {
        do {
            try fm.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            logw("CreateDB: couldn't create directory")
        }
    }
    private func createIndexJSON() {
        var data: JSON = [
            "created": NSDate().timeIntervalSince1970,
            "version": Friction().version,
        ]
        if (backup != nil) {
            data["backup"] = backup!
        }
        do {
            let raw = try data.rawData()
            let index = path.appendingPathComponent("index.json")
            
            fm.createFile(atPath: index.path, contents: raw, attributes: nil)
        } catch {
            logw("CreateDB: Couldn't create index.json")
        }
    }
    func create() {
        createDir(path: path.appendingPathComponent("Objects", isDirectory: true))
        createDir(path: path.appendingPathComponent("Entries", isDirectory: true))
        createDir(path: path.appendingPathComponent("Logs", isDirectory: true))
        createIndexJSON()
    }
}
