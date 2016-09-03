//
//  NotesVC.swift
//  EMG-PDF
//
//  Created by Will Fuger on 8/25/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

class NotesVC: UIViewController,
               UITextFieldDelegate,
               UITableViewDelegate {
    
    var project = ProjectModel()

    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var noteTitleLabel: UITextField!
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    @IBOutlet weak var titleBtn: UIButton!
    
    @IBOutlet weak var notesTableView: UITableView!
    
    
    
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
        print(project.notes!)
        noteTextField.text = ""
        notesTableView.estimatedRowHeight = 50.0
        notesTableView.rowHeight = UITableViewAutomaticDimension
        notesTableView.reloadData()
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
        
        notesTableView.delegate = self
//        notesTableView.dataSource = self
        
        noteTitleTextField.delegate = self
        noteTitleTextField.layer.borderColor = UIColor.blackColor().CGColor
        noteTitleTextField.layer.borderWidth = 1
        
        
        notesTableView.estimatedRowHeight = 50.0
        notesTableView.rowHeight = UITableViewAutomaticDimension
        notesTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        notesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text == noteTitleTextField.text
        {
            titleBtnDidPress(self)
        }
        else
        {
            addNoteBtn(self)
        }
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let notesCount = project.notes?.count
        {
            return notesCount
        }
        else
        {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "note")
        
        
        cell.textLabel?.text = "\u{2022} \(project.notes![indexPath.row])"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.sizeToFit()
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            project.notes?.removeAtIndex(indexPath.row)
            
            notesTableView.reloadData()
               
        }
        
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
