//
//  API_Manager.swift
//  EMG-PDF
//
//  Created by Will Fuger on 7/26/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import Foundation
import Alamofire

class API_Manager {
    
    
    func postZip(url: String, filePath: String, completion: String -> Void) {
        var zipData: NSData! = NSData()
        do {
//            let zipUrl = NSURL(fileReferenceLiteral: filePath)
            if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
                zipData = try NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                print("SUCCESSSS")
            } else {
                print("File does not exist")
            }
            
//            zipData = try NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        } catch {
            print("- error during get nsdata from zip file\(error)")
        }
        Alamofire.upload(.POST, url, headers: ["Content-Type": "application/zip"], data: zipData)
            .responseString { response in
                if response.result.isSuccess {
                    let responseValue = response.result.value
                    let responseCode = response.response?.statusCode
                    print("Response value is: \(responseValue!)")
                    print("Response code is: \(responseCode!)")
                } else {
                    var statusCode = 0
                    if (response.response != nil) {
                        statusCode = (response.response?.statusCode)!
                    }
                    print("Error: \(response.result.error!) with statusCode: \(statusCode)")
                }
        }
    }
    
}
