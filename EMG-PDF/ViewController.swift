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

