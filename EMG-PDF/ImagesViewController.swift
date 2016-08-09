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


class ImagesViewController: UIViewController,
                            UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate,
                            CustomOverlayDelegate,
                            ImagePickerDelegate {
    
    var imagePicker = UIImagePickerController()
    var imagePickerController = ImagePickerController()
    var counter = 1
    let url = "http://wills-macbook-air.local:3000/api/V1/2/bob"
    var form: [String : String]?
    
    @IBAction func getImages(
        sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            imagePicker.cameraCaptureMode = .Photo
            imagePicker.showsCameraControls = false
            let customViewController = CustomOverlayController(
                nibName: "CustomOverlayController",
                bundle: nil
            )
            let customView: CustomOverlayView = customViewController.view as! CustomOverlayView
            customView.frame = imagePicker.view.frame
            customView.delegate = self
            imagePicker.modalPresentationStyle = .FullScreen
            self.presentViewController(imagePicker, animated: true, completion: {
                    self.imagePicker.cameraOverlayView = customView
                })
        } else {
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .Alert)
            let okAction = UIAlertAction(
                title: "OK",
                style:.Default,
                handler: nil)
            alertVC.addAction(okAction)
            presentViewController(
                alertVC,
                animated: true,
                completion: nil)
        }
        
    }
    @IBAction func zipButton(sender: AnyObject) {
        imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
//        let zipPath = tempZipPath()
//        let photoPath = getDocumentsDirectory()
//        let success = SSZipArchive.createZipFileAtPath(zipPath, withContentsOfDirectory: photoPath as String)
//        if success {
//            print(success)
//            let api = API_Manager()
//            api.postZip(url, filePath: zipPath, completion: didPostZip)
//        }
        
    }
    
    func didPostZip(string: String) {
        print(string)
        print("Response from server")
    }
    
    func tempZipPath() -> String {
        var path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
        path += "/\(NSUUID().UUIDString).zip"
        print("Zip Path \(path)")
        return path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        print("Images from Done Buttons \(images)")
        for image in images
        {
            if let compressedData = UIImageJPEGRepresentation(image, 1)
            {
                let filename = getDocumentsDirectory().stringByAppendingPathComponent("\(counter)copy.jpg")
                print(filename)
                compressedData.writeToFile(filename, atomically: true)
                let compressedImage = UIImage(data: compressedData)
                UIImageWriteToSavedPhotosAlbum(compressedImage!, self,nil, nil)
                print("Success")
                counter += 1
            }
        }
        self.imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    func cancelButtonDidPress()
    {
        self.imagePickerController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done(overlayView: CustomOverlayView)
    {
        print("done")
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    func cancel(overlayView: CustomOverlayView)
    {
        print("cancelled")
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    func takePic(overlayView: CustomOverlayView)
    {
        imagePicker.takePicture()
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
        counter += 1
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        if let compressedData = UIImageJPEGRepresentation(chosenImage, 0.6)
        {
            let filename = getDocumentsDirectory().stringByAppendingPathComponent("\(counter)copy.jpg")
            print(filename)
            compressedData.writeToFile(filename, atomically: true)
            let compressedImage = UIImage(data: compressedData)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, self,nil, nil)
            print("Success")
        }
        
    }
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(
        picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func generatePDF()
    {
        var images = [UIImage]()
        let imageString = getDocumentsDirectory()
        do
        {
            var storedImages: [String]
            {
                return try! (NSFileManager().contentsOfDirectoryAtPath(imageString as String))
            }
            for file in storedImages
            {
                let img = UIImage(contentsOfFile: file)
                images.append(img!)
            }
        }
        let v1 = UIView(frame: CGRectMake(0, 0, 200, 200))
        let emgMainImg = UIImage(named: "EMG-Main.png")
        let emgMainImgView = UIImageView(image: emgMainImg!)
        emgMainImgView.frame = CGRectMake(25, 25, 150, 150)
        v1.addSubview(emgMainImgView)
        let photoSheetForm = UIView(frame: CGRectMake(0, 0, 200, 200))
        let mainImgPage = UIView(frame: CGRectMake(0, 0, 200, 200))
        let page1 = PDFPage.View(v1)
        let page2 = PDFPage.View(photoSheetForm)
        let page3 = PDFPage.View(mainImgPage)
        var pages = [PDFPage]()
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        for (i, img) in images.enumerate()
        {
            switch i
            {
                case images.count - 3:
                    let page = UIView(frame: CGRectMake(0, 0, 200, 200))
                    let img1 = UIImageView(image: img)
                    let img2 = UIImageView(image: images[i+1])
                    let img3 = UIImageView(image: images[i+2])
                    img1.frame = CGRectMake(25, 25, 75, 75)
                    img2.frame = CGRectMake(25, 175, 75, 75)
                    img3.frame = CGRectMake(175, 25, 75, 75)
                    page.addSubview(img1)
                    page.addSubview(img2)
                    page.addSubview(img3)
                    let pagePDF = PDFPage.View(page)
                    pages.append(pagePDF)
                case images.count - 2:
                    let page = UIView(frame: CGRectMake(0, 0, 200, 200))
                    let img1 = UIImageView(image: img)
                    let img2 = UIImageView(image: images[i+1])
                    img1.frame = CGRectMake(25, 25, 75, 75)
                    img2.frame = CGRectMake(25, 175, 75, 75)
                    page.addSubview(img1)
                    page.addSubview(img2)
                    let pagePDF = PDFPage.View(page)
                    pages.append(pagePDF)
                case images.count - 1:
                    let page = UIView(frame: CGRectMake(0, 0, 200, 200))
                    let img = UIImageView(image: img)
                    img.frame = CGRectMake(25, 25, 75, 75)
                    page.addSubview(img)
                    let pagePDF = PDFPage.View(page)
                    pages.append(pagePDF)
                default:
                    break
            }
            if i % 4 == 0 || i == 0
            {
                if i == images.count - 1 {
                    return
                }
                else
                {
                    let page = UIView(frame: CGRectMake(0, 0, 200, 200))
                    let img1 = UIImageView(image: img)
                    let img2 = UIImageView(image: images[i+1])
                    let img3 = UIImageView(image: images[i+2])
                    let img4 = UIImageView(image: images[i+3])
                    img1.frame = CGRectMake(25, 25, 75, 75)
                    img2.frame = CGRectMake(25, 175, 75, 75)
                    img3.frame = CGRectMake(175, 25, 75, 75)
                    img4.frame = CGRectMake(175, 175, 75, 75)
                    page.addSubview(img1)
                    page.addSubview(img2)
                    page.addSubview(img3)
                    page.addSubview(img4)
                    let pagePDF = PDFPage.View(page)
                    pages.append(pagePDF)
                }
            }
        }
        let dst = NSHomeDirectory().stringByAppendingString("/blah.pdf")
        do
        {
            try PDFGenerator.generate(pages, outputPath: dst)
        }
        catch (let error)
        {
            print(error)
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
