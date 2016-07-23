//
//  CustomOverlayView.swift
//  EMG-PDF
//
//  Created by Will Fuger on 7/23/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit

protocol CustomOverlayDelegate {
    func done(overlayView: CustomOverlayView)
    func cancel(overlayView: CustomOverlayView)
    func takePic(overlayView: CustomOverlayView)
}

class CustomOverlayView: UIView {
    
    var delegate: CustomOverlayDelegate! = nil

    @IBAction func done(sender: AnyObject) {
        delegate.done(self)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        delegate.cancel(self)
        
    }
    
    @IBAction func takePic(sender: AnyObject) {
        delegate.takePic(self)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
