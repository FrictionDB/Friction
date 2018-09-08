//
//  LoadJSON.swift
//  Friction-iOS
//
//  Created by Arthur Guiot on 6/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

class LoadJSON {
    var file: URL
    
    init(file: URL) {
        self.file = file
    }
    
    private func load(completionHandler: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: file) { (data, response, error) in
            if error != nil {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, error)
        }
    }
    
    private func parse(completionHandler: @escaping (JSON) -> Void) {
        self.load { (data, error) in
            if error != nil {
                logw((error as! Error).localizedDescription)
                completionHandler(JSON([])) // return empty JSON
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    let json = try JSON(data: data!)
                    completionHandler(json)
                } catch {
                    print("Error")
                }
                completionHandler(JSON(arrayLiteral: []))
            }
        }
    }
    
    func readFile(completionHandler: @escaping (Array<Any>) -> Void) {
        parse { (json) in
            completionHandler(json.arrayObject!)
        }
    }
}
