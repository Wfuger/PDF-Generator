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
    var projectInfo: [String : String]?
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
        
        if let projectInfo = projectInfo {
            print(projectInfo)
        }
        
        let footerImg = UIImage(named: "footer.png")
        let footerView = UIImageView(image: footerImg!)
        footerView.frame = CGRectMake(0, 1980, 1800, 270)
        
        let v1 = UIView(frame: CGRectMake(0, 0, 3000, 2250))
        v1.backgroundColor = UIColor.whiteColor()
        let emgMainImg = UIImage(named: "EMG-Main.png")
        let emgMainImgView = UIImageView(image: emgMainImg!)
        emgMainImgView.frame = CGRectMake(75, 60, 2850, 1500)
        v1.addSubview(emgMainImgView)
        let bottomBanner = UIImage(named: "bottomBanner.png")
        let bottomBannerImg = UIImageView(image: bottomBanner)
        bottomBannerImg.frame = CGRectMake(0, 1630, 3000, 500)
        v1.addSubview(bottomBannerImg)
        let siteText = UILabel(frame: CGRectMake(0, 1775, 3000, 225))
        siteText.text = "HD #\(projectInfo!["storeNum"]!) \(projectInfo!["storeName"]!)"
        siteText.textAlignment = NSTextAlignment.Center
        siteText.font = UIFont.systemFontOfSize(140)
        siteText.textColor = UIColor.darkGrayColor()
        v1.addSubview(siteText)
        let fDate = UILabel(frame: CGRectMake(0,1950,3000,125))
        fDate.text = projectInfo!["date"]
        fDate.textAlignment = NSTextAlignment.Center
        fDate.font = UIFont.systemFontOfSize(65)
        fDate.textColor = UIColor.grayColor()
        v1.addSubview(fDate)
        
        let photoSheetForm = UIView(frame: CGRectMake(0, 0, 3000, 2250))
        photoSheetForm.backgroundColor = UIColor.whiteColor()
        photoSheetForm.addSubview(footerView)
        let topImg = UIImage(named: "topImg.png")
        let topImgView = UIImageView(image: topImg!)
        topImgView.frame = CGRectMake(89, 86, 2822, 385)
        photoSheetForm.addSubview(topImgView)
        let photoSheetTitle = UILabel(frame: CGRectMake(554, 570, 1900, 217))
        photoSheetTitle.text = "Photo Sheet"
        photoSheetTitle.textAlignment = NSTextAlignment.Center
        photoSheetTitle.font = UIFont.boldSystemFontOfSize(100)
        photoSheetTitle.layer.borderColor = UIColor.blackColor().CGColor
        photoSheetTitle.layer.borderWidth = 1
        photoSheetForm.addSubview(photoSheetTitle)
        let label1 = UILabel(frame: CGRectMake(554, 787, 620, 217))
        let label1Text = "Store #:"
        label1.text = "\(label1Text)  "
        label1.textAlignment = NSTextAlignment.Right
        label1.font = UIFont.boldSystemFontOfSize(75)
        label1.layer.borderColor = UIColor.blackColor().CGColor
        label1.layer.borderWidth = 1
        photoSheetForm.addSubview(label1)
        let storeNumText = UILabel(frame: CGRectMake(1174, 787, 1280, 217))
        storeNumText.text = "  \(projectInfo!["storeNum"]!)"
        storeNumText.textAlignment = NSTextAlignment.Left
        storeNumText.font = UIFont.systemFontOfSize(75)
        storeNumText.layer.borderColor = UIColor.blackColor().CGColor
        storeNumText.layer.borderWidth = 1
        photoSheetForm.addSubview(storeNumText)
        let label2 = UILabel(frame: CGRectMake(554, 1004, 620, 217))
        let label2Text = "Store Name:"
        label2.text = "\(label2Text)  "
        label2.textAlignment = NSTextAlignment.Right
        label2.font = UIFont.boldSystemFontOfSize(75)
        label2.layer.borderColor = UIColor.blackColor().CGColor
        label2.layer.borderWidth = 1
        photoSheetForm.addSubview(label2)
        let storeNameText = UILabel(frame: CGRectMake(1174, 1004, 1280, 217))
        storeNameText.text = "  \(projectInfo!["storeName"]!)"
        storeNameText.textAlignment = NSTextAlignment.Left
        storeNameText.font = UIFont.systemFontOfSize(75)
        storeNameText.layer.borderColor = UIColor.blackColor().CGColor
        storeNameText.layer.borderWidth = 1
        photoSheetForm.addSubview(storeNameText)
        let label3 = UILabel(frame: CGRectMake(554, 1221, 620, 217))
        let label3Text = "Project Name:"
        label3.text = "\(label3Text)  "
        label3.textAlignment = NSTextAlignment.Right
        label3.font = UIFont.boldSystemFontOfSize(75)
        label3.layer.borderColor = UIColor.blackColor().CGColor
        label3.layer.borderWidth = 1
        photoSheetForm.addSubview(label3)
        let projectNameText = UILabel(frame: CGRectMake(1174, 1221, 1280, 217))
        projectNameText.text = "  \(projectInfo!["projectName"]!)"
        projectNameText.textAlignment = NSTextAlignment.Left
        projectNameText.font = UIFont.systemFontOfSize(75)
        projectNameText.layer.borderWidth = 1
        projectNameText.layer.borderColor = UIColor.blackColor().CGColor
        photoSheetForm.addSubview(projectNameText)
        let label4 = UILabel(frame: CGRectMake(554, 1438, 620, 217))
        let label4Text = "Project Manager:"
        label4.text = "\(label4Text)  "
        label4.textAlignment = NSTextAlignment.Right
        label4.font = UIFont.boldSystemFontOfSize(75)
        label4.layer.borderColor = UIColor.blackColor().CGColor
        label4.layer.borderWidth = 1
        photoSheetForm.addSubview(label4)
        let projectMngText = UILabel(frame: CGRectMake(1174, 1438, 1280, 217))
        projectMngText.text = "  \(projectInfo!["projectMngName"]!)"
        projectMngText.textAlignment = NSTextAlignment.Left
        projectMngText.font = UIFont.systemFontOfSize(75)
        projectMngText.layer.borderColor = UIColor.blackColor().CGColor
        projectMngText.layer.borderWidth = 1
        photoSheetForm.addSubview(projectMngText)
        let label5 = UILabel(frame: CGRectMake(554, 1655, 620, 217))
        let label5Text = "Date:"
        label5.text = "\(label5Text)  "
        label5.textAlignment = NSTextAlignment.Right
        label5.font = UIFont.boldSystemFontOfSize(75)
        label5.layer.borderColor = UIColor.blackColor().CGColor
        label5.layer.borderWidth = 1
        photoSheetForm.addSubview(label5)
        let date = UILabel(frame: CGRectMake(1174, 1655, 1280, 217))
        date.text = "  \(projectInfo!["date"]!)"
        date.textAlignment = NSTextAlignment.Left
        date.font = UIFont.systemFontOfSize(75)
        date.layer.borderWidth = 1
        date.layer.borderColor = UIColor.blackColor().CGColor
        photoSheetForm.addSubview(date)
        
        let page1 = PDFPage.View(v1)
        let page2 = PDFPage.View(photoSheetForm)
        pages.append(page1)
        pages.append(page2)
        
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
        let footerImg = UIImage(named: "footer.png")
        let footerView = UIImageView(image: footerImg!)
        footerView.frame = CGRectMake(0, 1980, 1800, 270)
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
            let width: CGFloat = 942
            let height: CGFloat = 702
            let x1: CGFloat = 307.5
            let x2: CGFloat = 1749
            let y1: CGFloat = 394.5
            let y2: CGFloat = 1153.5
            if miniImages.count % 4 == 3 && i == miniImages.count - 4
            {
                print("wtf mate 3 \(i)")
                let page = UIView(frame: CGRectMake(0, 0, 3000, 2250))
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
                page.addSubview(footerView)
                let pagePDF = PDFPage.View(page)
                pages.append(pagePDF)
                print("pages count \(pages.count)")
                
            }
            else if miniImages.count % 4 == 2 && i == miniImages.count - 3
            {
                print("wtf mate 2 \(i)")
                let page = UIView(frame: CGRectMake(0, 0, 3000, 2250))
                page.backgroundColor = UIColor.whiteColor()
                let img1 = UIImageView(image: miniImages[i + 1])
                let img2 = UIImageView(image: miniImages[i + 2])
                img1.frame = CGRectMake(x1, y1, width, height)
                img2.frame = CGRectMake(x2, y1, width, height)
                page.addSubview(img1)
                page.addSubview(img2)
                page.addSubview(footerView)
                let pagePDF = PDFPage.View(page)
                pages.append(pagePDF)
                print("pages count \(pages.count)")
                
            }
            else if miniImages.count % 4 == 1 && i == miniImages.count - 2
            {
                print("wtf mate 1 \(i)")
                let page = UIView(frame: CGRectMake(0, 0, 3000, 2250))
                page.backgroundColor = UIColor.whiteColor()
                let img = UIImageView(image: miniImages[i + 1])
                img.frame = CGRectMake(x1, y1, width, height)
                page.addSubview(img)
                page.addSubview(footerView)
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
                    let page = UIView(frame: CGRectMake(0, 0, 3000, 2250))
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
                    let footerImg = UIImage(named: "footer.png")
                    let footerView = UIImageView(image: footerImg!)
                    footerView.frame = CGRectMake(0, 1980, 1800, 270)
                    page.addSubview(footerView)
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
            let footerImg = UIImage(named: "footer.png")
            let footerView = UIImageView(image: footerImg!)
            footerView.frame = CGRectMake(0, 1980, 1800, 270)
            let compressedImage = UIImage(data: compressedData)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, self,nil, nil)
            print("Success")
            let mainImagePage = UIView(frame: CGRectMake(0, 0, 3000, 2250))
            mainImagePage.backgroundColor = UIColor.whiteColor()
            let mainImageView = UIImageView(image: compressedImage!)
            mainImageView.frame = CGRectMake(384, 291.9, 2244, 1668)
            mainImagePage.addSubview(mainImageView)
            mainImagePage.addSubview(footerView)
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
        let finalPage = UIView(frame: CGRectMake(0, 0, 3000, 2250))
        finalPage.backgroundColor = UIColor.whiteColor()
        let finalImg = UIImageView(frame: CGRectMake(75, 60, 2850, 1500))
        finalImg.image = UIImage(named: "endImg.png")
        finalPage.addSubview(finalImg)
        let bottomBanner = UIImage(named: "bottomBanner.png")
        let bottomBannerImg = UIImageView(image: bottomBanner)
        bottomBannerImg.frame = CGRectMake(0, 1630, 3000, 500)
        finalPage.addSubview(bottomBannerImg)
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
            mailComposer.setSubject("Home Depot #\(projectInfo!["storeNum"]!) \(projectInfo!["storeName"]!)- \(projectInfo!["projectName"]!) Photos, \(projectInfo!["date"]!)")
            mailComposer.setMessageBody("This is what they sound like.", isHTML: false)
            mailComposer.setToRecipients(["wfuger@gmail.com"])
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
