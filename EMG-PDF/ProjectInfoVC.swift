//
//  ViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/28/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class ProjectInfoVC: UIViewController,
                     UIPickerViewDataSource,
                     UIPickerViewDelegate,
                     UITextFieldDelegate {
    @IBOutlet weak var storeNumTextField: UITextField!
    
    @IBOutlet weak var storeNameTextField: UITextField!
    
    @IBOutlet weak var projectNamePicker: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func addImagesBtn(sender: AnyObject) {
        
        projecInfo["storeNum"] = storeNumTextField.text!
        projecInfo["storeName"] = storeNameTextField.text!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let dateStr = dateFormatter.stringFromDate(datePicker.date)
        projecInfo["date"] = dateStr
        projecInfo["projectName"] = pickerData[projectNamePicker.selectedRowInComponent(0)]
        
    }
    let pickerData = ["90% Walk", "Pre-bid Walk", "Pre-Con Walk", "Weekly Visit", "Punch Walk"]
    var projecInfo = [String:String]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)

    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.storeNameTextField.layer.borderColor = UIColor.blackColor().CGColor
        self.storeNameTextField.layer.borderWidth = 1
        self.storeNumTextField.layer.borderColor = UIColor.blackColor().CGColor
        self.storeNumTextField.layer.borderWidth = 1
        self.projectNamePicker.dataSource = self
        self.projectNamePicker.delegate = self
        self.storeNumTextField.delegate = self
        self.storeNameTextField.delegate = self
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ImgNotesSegue"
        {
            let TBC = segue.destinationViewController as! UITabBarController
            let controller = TBC.viewControllers![0] as! ImagesVC
            controller.projectInfo = self.projecInfo
        }
    }
}

