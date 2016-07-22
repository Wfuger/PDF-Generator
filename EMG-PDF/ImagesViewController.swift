//
//  ImagesViewController.swift
//  EMG-PDF
//
//  Created by Will Fuger on 6/29/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import DKImagePickerController
import SSZipArchive

class ImagesViewController: UIViewController {
    
    var photos: [AnyObject] = []
    
    @IBAction func getImages(sender: AnyObject) {
        
        let pickerController = DKImagePickerController()
        pickerController.assetType = .AllPhotos
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            
            
            print(assets)
            let assetMirror = Mirror(reflecting: assets)
            print(assetMirror.subjectType)
            self.photos = assets
            
        }
        
        self.presentViewController(pickerController, animated: true) {}
        
    }
    @IBAction func zipButton(sender: AnyObject) {
        
//        let sampleDataPath = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("Sample Data").path
//        let zipPath = tempZipPath()
        
        
        
//        let success = SSZipArchive.createZipFileAtPath(zipPath, withFilesAtPaths: photos)
//        if success {
//            print(success)
//        }
        
    }
    
    func tempZipPath() -> String {
        var path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
        path += "/\(NSUUID().UUIDString).zip"
        return path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
