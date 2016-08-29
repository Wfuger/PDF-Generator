//
//  ProjectObject.swift
//  EMG-PDF
//
//  Created by Will Fuger on 8/27/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import PDFGenerator

class ProjectModel: NSObject {

    var notes: [String]?
    var notesTitle: String?
    var pages = [PDFPage]()
    var images = [UIImage]()
    var tempImgs = [UIImage]()
    
    func getEmail() -> String
    {
        let managerInfo = NSUserDefaults.standardUserDefaults().objectForKey("mngrInfo") as! [String: String]
        if let email = managerInfo["email"] {
            return email
        } else {
            return ""
        }
        
    }

}
