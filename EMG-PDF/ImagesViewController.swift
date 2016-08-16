//
//  ImagesViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/29/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import SSZipArchive
import PDFGenerator
import ImagePicker
import MessageUI


class ImagesViewController: UIViewController,
                            UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate,
                            ImagePickerDelegate,
                            MFMailComposeViewControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var imagePickerController = ImagePickerController()
    var counter = 0
    var form: [String : String]?
    var miniImages = [UIImage]()
    var pages = [PDFPage]()
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v1 = UIView(frame: CGRectMake(0, 0, 100, 75))
        v1.backgroundColor = UIColor.whiteColor()
        let emgMainImg = UIImage(named: "EMG-Main.png")
        let emgMainImgView = UIImageView(image: emgMainImg!)
        emgMainImgView.frame = CGRectMake(2.5, 2.5, 95, 55.5)
        v1.addSubview(emgMainImgView)
        let photoSheetForm = UIView(frame: CGRectMake(0, 0, 100, 75))
        photoSheetForm.backgroundColor = UIColor.whiteColor()
        let page1 = PDFPage.View(v1)
        let page2 = PDFPage.View(photoSheetForm)
        pages.append(page1)
        pages.append(page2)
        print(form!)
        
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
        for image in images
        {
            
            if let compressedData = UIImageJPEGRepresentation(image, 0.01)
            {
                let compressedImage = UIImage(data: compressedData)
                miniImages.append(compressedImage!)
                print("Image count \(miniImages.count)")
            }
        }
        for (i, img) in miniImages.enumerate()
        {
            let width: CGFloat = 31.4
            let height: CGFloat = 23.4
            let x1: CGFloat = 10.25
            let x2: CGFloat = 58.3
            let y1: CGFloat = 13.15
            let y2: CGFloat = 38.45
            if miniImages.count % 4 == 3 && i == miniImages.count - 4
            {
                print("wtf mate 3 \(i)")
                let page = UIView(frame: CGRectMake(0, 0, 100, 75))
                page.backgroundColor = UIColor.whiteColor()
                let img1 = UIImageView(image: miniImages[i + 1])
                let img2 = UIImageView(image: miniImages[i + 2])
                let img3 = UIImageView(image: miniImages[i + 3])
                img1.frame = CGRectMake(x1, y1, width, height)
                img2.frame = CGRectMake(x2, y1, width, height)
                img3.frame = CGRectMake(x1, y2, width, height)
                page.addSubview(img1)
                page.addSubview(img2)
                page.addSubview(img3)
                let pagePDF = PDFPage.View(page)
                pages.append(pagePDF)
                print("pages count \(pages.count)")
                
            }
            else if miniImages.count % 4 == 2 && i == miniImages.count - 3
            {
                print("wtf mate 2 \(i)")
                let page = UIView(frame: CGRectMake(0, 0, 100, 75))
                page.backgroundColor = UIColor.whiteColor()
                let img1 = UIImageView(image: miniImages[i + 1])
                let img2 = UIImageView(image: miniImages[i + 2])
                img1.frame = CGRectMake(x1, y1, width, height)
                img2.frame = CGRectMake(x2, y1, width, height)
                page.addSubview(img1)
                page.addSubview(img2)
                let pagePDF = PDFPage.View(page)
                pages.append(pagePDF)
                print("pages count \(pages.count)")
                
            }
            else if miniImages.count % 4 == 1 && i == miniImages.count - 2
            {
                print("wtf mate 1 \(i)")
                let page = UIView(frame: CGRectMake(0, 0, 100, 75))
                page.backgroundColor = UIColor.whiteColor()
                let img = UIImageView(image: miniImages[i + 1])
                img.frame = CGRectMake(x1, y1, width, height)
                page.addSubview(img)
                let pagePDF = PDFPage.View(page)
                pages.append(pagePDF)
                print("pages count \(pages.count)")
                
            }
            else if i % 4 == 0 || i == 0
            {
                if (miniImages.count - i) <= 4
                {
                    break
                }
                else
                {
                    print("mini image page \(i)")
                    let page = UIView(frame: CGRectMake(0, 0, 100, 75))
                    page.backgroundColor = UIColor.whiteColor()
                    let img1 = UIImageView(image: img)
                    let img2 = UIImageView(image: miniImages[i + 1])
                    let img3 = UIImageView(image: miniImages[i + 2])
                    let img4 = UIImageView(image: miniImages[i + 3])
                    img1.frame = CGRectMake(x1, y1, width, height)
                    img2.frame = CGRectMake(x2, y1, width, height)
                    img3.frame = CGRectMake(x1, y2, width, height)
                    img4.frame = CGRectMake(x2, y2, width, height)
                    page.addSubview(img1)
                    page.addSubview(img2)
                    page.addSubview(img3)
                    page.addSubview(img4)
                    let pagePDF = PDFPage.View(page)
                    pages.append(pagePDF)
                    print("pages count \(pages.count)")
                }
            }
        }
        miniImages.removeAll()
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
        if let compressedData = UIImageJPEGRepresentation(chosenImage, 0.1)
        {
            let compressedImage = UIImage(data: compressedData)
//            UIImageWriteToSavedPhotosAlbum(compressedImage!, self,nil, nil)
            print("Success")
            let mainImagePage = UIView(frame: CGRectMake(0, 0, 100, 75))
            mainImagePage.backgroundColor = UIColor.whiteColor()
            let mainImageView = UIImageView(image: compressedImage!)
            mainImageView.frame = CGRectMake(12.8, 9.73, 74.8, 55.6)
            mainImagePage.addSubview(mainImageView)
            let mainImgPDF = PDFPage.View(mainImagePage)
            pages.append(mainImgPDF)
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
        
        
        
        print("it's getting here")
        print("pages count \(pages.count)")
        let finalPage = UIView(frame: CGRectMake(0, 0, 100, 75))
        finalPage.backgroundColor = UIColor.whiteColor()
//        let finalImg = UIImageView(frame: CGRectMake(10, 10, 180, 180))
//        finalImg.image = UIImage(named: "finalImg.png")
//        finalPage.addSubview(finalImg)
        let finalPDFPage = PDFPage.View(finalPage)
        pages.append(finalPDFPage)
        let dst = getDocumentsDirectory().stringByAppendingString("/blah.pdf")
        do
        {
            try PDFGenerator.generate(pages, outputPath: dst)
        }
        catch (let error)
        {
            print("pdf-gen error\(error)")
        }
        
        emailPDF()
        
    }
    
    func emailPDF() {
        miniImages.removeAll()
        
        let pdfDestination = getDocumentsDirectory().stringByAppendingString("/blah.pdf")
        
        if( MFMailComposeViewController.canSendMail() )
        {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            mailComposer.setSubject("Have you heard a fart?")
            mailComposer.setMessageBody("This is what they sound like.", isHTML: false)
            if let fileData = NSData(contentsOfFile: pdfDestination)
            {
                print("File data loaded.")
                mailComposer.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "blah")
            }
            self.presentViewController(mailComposer, animated: true, completion: nil)
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if (error != nil) {
            print(error!)
        }
        if result == MFMailComposeResultSent {
            print("Fuck yeah bitches, but wheres my email?")
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
