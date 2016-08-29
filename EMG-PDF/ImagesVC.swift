//
//  ImagesViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/29/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import PDFGenerator
import ImagePicker
import MessageUI


class ImagesVC: UIViewController,
                UIImagePickerControllerDelegate,
                UINavigationControllerDelegate,
                ImagePickerDelegate,
                MFMailComposeViewControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var imagePickerController = ImagePickerController()
    var counter = 0
    
    var project = ProjectModel()
    let pageMaker = PDFModel()
    var projectInfo: [String: String]?
    var email = String()
    
    
    @IBAction func mainImgFromLibrary(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func mainImgSelector(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            imagePicker.cameraCaptureMode = .Photo
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func getImages(
        sender: AnyObject)
    {
        imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    @IBAction func zipButton(sender: AnyObject) {
        generatePDF()
        
    }
    
    override func viewWillAppear(animated: Bool) {

        let tbc = self.tabBarController as! NotesTBC
        project = tbc.project

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbc = self.tabBarController as! NotesTBC
        project = tbc.project
        
        let page1 = pageMaker.page1(projectInfo!)
        project.pages.append(page1)
        
        let page2 = pageMaker.photoSheetPage(projectInfo!)
        project.pages.append(page2)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("SHIT")
    }
    
    func wrapperDidPress(images: [UIImage]) {
        print("Images from wrapper\(images)")
    }
    
    func doneButtonDidPress(images: [UIImage])
    {
        if project.tempImgs.count != 0
        {
            project.images.appendContentsOf(project.tempImgs)
            project.tempImgs.removeAll()
        }
        let footerImg = UIImage(named: "footer.png")
        let footerView = UIImageView(image: footerImg!)
        footerView.frame = CGRectMake(0, 1980, 1800, 270)
        
        for image in images
        {
            if let compressedData = UIImageJPEGRepresentation(image, 0.001)
            {
                let compressedImage = UIImage(data: compressedData)
                project.images.append(compressedImage!)
                print("Image count \(project.images.count)")
            }
        }

        let imgCount = project.images.count
        switch imgCount % 4 {
        case 1:
            project.tempImgs.append(project.images.removeLast())
        case 2:
            project.tempImgs.append(project.images.removeLast())
            project.tempImgs.append(project.images.removeLast())
        case 3:
            project.tempImgs.append(project.images.removeLast())
            project.tempImgs.append(project.images.removeLast())
            project.tempImgs.append(project.images.removeLast())
        default:
            break
        }
        if project.images.count != 0
        {
            let imgPages = pageMaker.smallImgPages(project.images)
            project.pages.appendContentsOf(imgPages)
        }
            project.images.removeAll()
        self.imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    func cancelButtonDidPress()
    {
        self.imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }

    func getDocumentsDirectory() -> NSString
    {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        return documentsDirectory
    }
    
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        if let compressedData = UIImageJPEGRepresentation(chosenImage, 0.001)
        {
            let compressedImage = UIImage(data: compressedData)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, self,nil, nil)
            let mainImgPage = pageMaker.mainImgPage(compressedImage!)
            project.pages.insert(mainImgPage, atIndex: 2)
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(
        picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func generatePDF()
    {
        
        if let notes = project.notes {
            print(notes)
            let notesPages = pageMaker.notesPage(notes, title: nil)
            project.pages.insertContentsOf(notesPages, at: 2)
        }
        
        if project.tempImgs.count != 0
        {
            print("odd imgs")
            let oddPage = pageMaker.oddLastSmallImgPage(project.tempImgs)
            project.pages.append(oddPage)
            project.tempImgs.removeAll()
        }
        let finalPage = pageMaker.finalPage()
        project.pages.append(finalPage)
        let dst = getDocumentsDirectory().stringByAppendingString("/blah.pdf")
        do
        {
            
            try PDFGenerator.generate(project.pages, outputPath: dst)
        }
        catch (let error)
        {
            print("pdf-gen error \(error)")
        }
        
        emailPDF()
        
    }
    
    func emailPDF() {
        project.images.removeAll()
//        project.pages.removeRange((project.pages.count - 1)..<2)
        
        
        let pdfDestination = getDocumentsDirectory().stringByAppendingString("/blah.pdf")
        
        if( MFMailComposeViewController.canSendMail() )
        {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            mailComposer.setSubject("Home Depot #\(projectInfo!["storeNum"]!) \(projectInfo!["storeName"]!)- \(projectInfo!["projectName"]!) Photos, \(projectInfo!["date"]!)")
            mailComposer.setToRecipients([project.getEmail()])
            if let fileData = NSData(contentsOfFile: pdfDestination)
            {
                print("File data loaded.")
                mailComposer.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "Home Depot #\(projectInfo!["storeNum"]!) \(projectInfo!["storeName"]!)- \(projectInfo!["projectName"]!) Photos, \(projectInfo!["date"]!).pdf")
            }
            self.presentViewController(mailComposer, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
