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


class ImagesViewController: UIViewController,
                            UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate,
                            CustomOverlayDelegate {
    
    var imagePicker = UIImagePickerController()
    var counter = 0
    let url = "http://wills-macbook-air.local:3000/api/V1/2/bob"
    
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
        let zipPath = tempZipPath()
        let photoPath = getDocumentsDirectory()
        let success = SSZipArchive.createZipFileAtPath(zipPath, withContentsOfDirectory: photoPath as String)
        if success {
            print(success)
            let api = API_Manager()
            api.postZip(url, filePath: zipPath, completion: didPostZip)
        }
        
    }
    
    func didPostZip(string: String) {
        print(string)
        print("Respons from server")
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
    
    func done(overlayView: CustomOverlayView) {
        print("done")
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    func cancel(overlayView: CustomOverlayView) {
        print("cancelled")
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    func takePic(overlayView: CustomOverlayView) {
        imagePicker.takePicture()
    }
    func getDocumentsDirectory() -> NSString {
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
    
    func generatePDF() {
        var images = [UIImage]()
        let imageString = getDocumentsDirectory()
        let imageUrl = NSURL(string: imageString as String)
        do {
            var storedImages: [String] {
                let imgs = try! (NSFileManager().contentsOfDirectoryAtPath(imageString as String))
//                let imgs = try! (NSFileManager().contentsOfDirectoryAtURL(imageUrl!, includingPropertiesForKeys: nil, options: [.SkipsHiddenFiles, .SkipsSubdirectoryDescendants, .SkipsPackageDescendants]) as [String])
                return imgs
            }
            for file in storedImages {
//                images.append(file)
                let img = UIImage(contentsOfFile: file)
                images.append(img!)
            }
        }
        
        for (index, image) in images {
            let pageNum = "page\(index)"
            let page = PDFPage.Image(image)
            
            
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
