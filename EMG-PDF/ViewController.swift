//
//  ViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/28/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var storeNumTextField: UITextField!
    
    @IBOutlet weak var storeNameTextField: UITextField!
    
    @IBOutlet weak var projectNamePicker: UIPickerView!
    
    @IBOutlet weak var projectMngrTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func addImagesBtn(sender: AnyObject) {
        
        form["storeNum"] = storeNumTextField.text!
        form["storeName"] = storeNameTextField.text!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let dateStr = dateFormatter.stringFromDate(datePicker.date)
        form["date"] = dateStr
        form["projectMngName"] = projectMngrTextField.text!
        form["projectName"] = pickerData[projectNamePicker.selectedRowInComponent(0)]
    }
    var pickerData = [String]()
    
    var isAuthenticated = true
    
    var didReturnFromBackground = false
    
    var form = [String:String]()
     
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    @IBAction func unwindToForm(segue: UIStoryboardSegue) {
        
    }
    

    
//    func appWillResignActive(notification : NSNotification) {
//        
//        view.alpha = 0
//        isAuthenticated = false
//        didReturnFromBackground = true
//    }
    
    func appDidBecomeActive(notification : NSNotification) {
        
//        if didReturnFromBackground {
//            self.showLoginView()
//        }
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
//        view.alpha = 0
        
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.appWillResignActive(_:)), name: UIApplicationWillResignActiveNotification, object: nil)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.appDidBecomeActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
//        self.showLoginView()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
//    func showLoginView() {
//        
//        if !isAuthenticated {
//            
//            self.performSegueWithIdentifier("loginView", sender: self)
//        }
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.storeNameTextField.layer.borderColor = UIColor.blackColor().CGColor
        self.storeNameTextField.layer.borderWidth = 1
        self.storeNumTextField.layer.borderColor = UIColor.blackColor().CGColor
        self.storeNumTextField.layer.borderWidth = 1
        self.projectMngrTextField.layer.borderColor = UIColor.blackColor().CGColor
        self.projectMngrTextField.layer.borderWidth = 1
        
        self.projectNamePicker.dataSource = self
        self.projectNamePicker.delegate = self
        self.storeNumTextField.delegate = self
        self.storeNameTextField.delegate = self
        self.projectMngrTextField.delegate = self
        
        
        
        pickerData = ["90% Walk", "Pre-bid Walk", "Pre-Con Walk", "Weekly Visit", "Punch Walk"]
        
    }
    
    // Keyboard closes when user hits enter
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // Keyboard resides when touching elsewhere on screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "imagesSegue"
        {
            let controller = segue.destinationViewController as! ImagesViewController
            controller.form = self.form
        }
    }
}

