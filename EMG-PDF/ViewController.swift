//
//  ViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/28/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var storeNumTextField: UITextField!
    
    @IBOutlet weak var storeNameTextField: UITextField!
    
    @IBOutlet weak var projectNamePicker: UIPickerView!
    
    var pickerData = [String]()
    
    var isAuthenticated = false
    
    var didReturnFromBackground = false
     
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
        isAuthenticated = true
        view.alpha = 1.0
    }
    
    func appWillResignActive(notification : NSNotification) {
        
        view.alpha = 0
        isAuthenticated = false
        didReturnFromBackground = true
    }
    
    func appDidBecomeActive(notification : NSNotification) {
        
        if didReturnFromBackground {
            self.showLoginView()
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        view.alpha = 0
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.appWillResignActive(_:)), name: UIApplicationWillResignActiveNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.appDidBecomeActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
        self.showLoginView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showLoginView() {
        
        if !isAuthenticated {
            
            self.performSegueWithIdentifier("loginView", sender: self)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        storeNameTextField.layer.borderColor = UIColor.blackColor().CGColor
        storeNumTextField.layer.borderColor = UIColor.blackColor().CGColor
        
        self.projectNamePicker.dataSource = self
        self.projectNamePicker.delegate = self
        
        pickerData = ["90% Walk", "Pre-bid Walk", "Pre-Con Walk", "Weekly Visit", "Punch Walk"]
        
    }

    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerData[row])
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
}

