//
//  ObjectsStream.swift
//  Friction-iOS
//
//  Created by Arthur Guiot on 4/9/18.
//  Copyright © 2018 FrictionDB. All rights reserved.
//

import Foundation

import Foundation
import Darwin.Mach.mach_time

class ObjectsStream:NSObject {
    
    var copyOutput:OutputStream?
    var fileInput:InputStream?
    var outputStream:OutputStream? = OutputStream(toMemory: ())
    var urlInput:NSURL?
    
    convenience init(srcURL:NSURL, targetURL:NSURL) {
        self.init()
        self.fileInput  = InputStream(url: srcURL as URL)
        self.copyOutput = OutputStream(url: targetURL as URL, append: false)
        self.urlInput   = srcURL
        
    }
    
    func copyFileURLToURL(destURL:NSURL, withProgressBlock block: (_ fileSize:Double,_ percent:Double,_ estimatedTimeRemaining:Double) -> ()){
        
        guard let copyOutput = self.copyOutput, let fileInput = self.fileInput, let urlInput = self.urlInput else { return }
        
        let fileSize            = sizeOfInputFile(src: urlInput)
        let bufferSize          = 4096
        let buffer              = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        var bytesToWrite        = 0
        var bytesWritten        = 0
        var counter             = 0
        var copySize            = 0
        
        fileInput.open()
        copyOutput.open()
        
        //start time
        let time0 = mach_absolute_time()
        
        while fileInput.hasBytesAvailable {
            
            repeat {
                
                bytesToWrite    = fileInput.read(buffer, maxLength: bufferSize)
                bytesWritten    = copyOutput.write(buffer, maxLength: bufferSize)
                
                //check for errors
                if bytesToWrite < 0 {
                    print(fileInput.streamStatus.rawValue)
                }
                if bytesWritten == -1 {
                    print(copyOutput.streamStatus.rawValue)
                }
                //move read pointer to next section
                bytesToWrite -= bytesWritten
                copySize += bytesWritten
                
                if bytesToWrite > 0 {
                    //move block of memory
                    memmove(buffer, buffer + bytesWritten, bytesToWrite)
                }
                
            } while bytesToWrite > 0
            
            counter += 1 // Every 4096 bytes
            
            if fileSize != nil && (counter % 10 == 0) {
                //passback a progress tuple
                let percent     = Double(copySize / fileSize!)
                let time1       = mach_absolute_time()
                let elapsed     = Double (time1 - time0) / Double(NSEC_PER_SEC)
                let estTimeLeft = ((1 - percent) / percent) * elapsed
                
                block(Double(copySize), percent, estTimeLeft)
            }
        }
        
        //send final progress tuple
        block(Double(copySize), 1, 0)
        
        
        //close streams
        if fileInput.streamStatus == .atEnd {
            fileInput.close()
            
        }
        if copyOutput.streamStatus != .writing && copyOutput.streamStatus != .error {
            copyOutput.close()
        }
        
        
        
    }
    
    func sizeOfInputFile(src:NSURL) -> Int? {
        
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: src.path!)
            var fileSize = attr[FileAttributeKey.size] as! UInt64
            
            //if you convert to NSDictionary, you can get file size old way as well.
            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
            return Int(fileSize)
            
        } catch let inputFileError as NSError {
            print(inputFileError.localizedDescription, inputFileError.localizedRecoverySuggestion)
        }
        
        return nil
    }
    
    
}
