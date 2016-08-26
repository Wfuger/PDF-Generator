//
//  LoginViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/29/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class ContactInfoVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBAction func saveButton(sender: AnyObject) {
        var mngrInfo = [String: AnyObject]()
        mngrInfo["name"] = nameTextField.text!
        mngrInfo["email"] = emailTextField.text!
        mngrInfo["phoneNum"] = phoneNumTextField.text!
//        NSUserDefaults.resetStandardUserDefaults()
//        print(mngrInfo)
        defaults.setObject(mngrInfo, forKey: "mngrInfo")
        if let someShit = defaults.objectForKey("mngrInfo") as? [String: String]
        {
            print("WHAT IN THE FUCKING FUCK? \(someShit)")
            performSegueWithIdentifier("toProjectInfo", sender: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ContactInfoVC.appDidBecomeActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumTextField.delegate = self
        print(defaults.objectForKey("mngrInfo") as? [String: String])
//        hasMngrInfo()
        
    }
    func appDidBecomeActive(notification: NSNotification) {
        hasMngrInfo()
    }
    func hasMngrInfo() {
        if (defaults.objectForKey("mngrInfo") != nil)
        {
            let mngrInfo = defaults.objectForKey("mngrInfo") as? [String: String] ?? [String: String]()
            print("it's there \(mngrInfo["name"])")
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
    

    // TODO: set mngr details to nsuserdefaults


}
