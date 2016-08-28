//
//  LoginViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/29/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

extension String {
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}

class ContactInfoVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var mngrInfo = [String: String]()
    
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        mngrInfo["name"] = nameTextField.text!
        mngrInfo["email"] = emailTextField.text!
        var num = phoneNumTextField.text!
        num = num.insert(".", ind: 3)
        num = num.insert(".", ind: 7)
        
        
        mngrInfo["phoneNum"] = num
        defaults.setObject(mngrInfo, forKey: "mngrInfo")
        hasMngrInfo()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ContactInfoVC.appDidBecomeActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumTextField.delegate = self
        
    }
    func appDidBecomeActive(notification: NSNotification) {
        hasMngrInfo()
    }
    func hasMngrInfo() {
        if (defaults.objectForKey("mngrInfo") != nil)
        {
            performSegueWithIdentifier("toProjectInfo", sender: nil)
        } else {
            print("it's not there")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}
