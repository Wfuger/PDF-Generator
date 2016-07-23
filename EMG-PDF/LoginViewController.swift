//
//  LoginViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/29/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    let emailKey = "batman@ex.com"
    let passwordKey = "nananana"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func login(sender: AnyObject) {
        
        self.performSegueWithIdentifier("unwindToForm", sender: self)
        print("wtf")
        if (checkLogin(self.emailTextField.text!, password: self.passwordTextField.text!)) {
            
        }
    }
    

    func checkLogin(email:String, password:String) -> Bool {
        if ((email == emailKey) && (password == passwordKey)){
            return true
        } else {
            return false
        }
    }

}
