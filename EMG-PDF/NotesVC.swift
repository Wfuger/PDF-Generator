//
//  NotesVC.swift
//  EMG-PDF
//
//  Created by Will Fuger on 8/25/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class NotesVC: UIViewController,
               UITextFieldDelegate {
    
    var project = ProjectModel()

    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var noteTitleLabel: UITextField!
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    @IBOutlet weak var titleBtn: UIButton!
    
    @IBAction func titleBtnDidPress(sender: AnyObject) {
        
        project.notesTitle = noteTitleTextField.text!
        titleBtn.hidden = true
        noteTitleTextField.hidden = true
        print("title from notes vc \(project.notesTitle)")
        
    }
    @IBAction func addNoteBtn(sender: AnyObject) {
        if project.notes == nil {
            project.notes = [noteTextField.text!]
        } else {
            project.notes?.append(noteTextField.text!)   
        }
        print(project.notes)
        noteTextField.text = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        let tbc = self.tabBarController as! NotesTBC
        project = tbc.project
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tbc = self.tabBarController as! NotesTBC
        project = tbc.project

        noteTextField.delegate = self
        noteTextField.layer.borderColor = UIColor.blackColor().CGColor
        noteTextField.layer.borderWidth = 1
        
        noteTitleTextField.delegate = self
        noteTitleTextField.layer.borderColor = UIColor.blackColor().CGColor
        noteTitleTextField.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == noteTitleTextField
        {
            addNoteBtn(self)
        }
        else
        {
            titleBtnDidPress(self)
        }
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
