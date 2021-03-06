//
//  PDFModel.swift
//  EMG-PDF
//
//  Created by Will Fuger on 8/27/16.
//  Copyright © 2016 boogiesquad. All rights reserved.
//

import UIKit
import PDFGenerator

class PDFModel: NSObject {
    
    let pageWidth: CGFloat = 3000
    let pageHeight: CGFloat = 2250
    let contactInfo = NSUserDefaults.standardUserDefaults().objectForKey("mngrInfo") as! [String: String]
    let project = ProjectModel()
    
    func getFooter() -> UIImageView
    {
        let footerImg = UIImage(named: "footer.png")
        let footerView = UIImageView(image: footerImg!)
        footerView.frame = CGRectMake(0, 1980, 1800, 270)
        return footerView
    }

    func page1(storeInfo: [String: String]) -> PDFPage
    {
        
        // Create page view
        let v1 = UIView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
        v1.backgroundColor = UIColor.whiteColor()
        
        // Add the main image to the view
        let emgMainImg = UIImage(named: "EMG-Main.png")
        let emgMainImgView = UIImageView(image: emgMainImg!)
        emgMainImgView.frame = CGRectMake(75, 60, 2850, 1500)
        v1.addSubview(emgMainImgView)
        
        // Add the banner below main image
        let bottomBanner = UIImage(named: "bottomBanner.png")
        let bottomBannerImg = UIImageView(image: bottomBanner)
        bottomBannerImg.frame = CGRectMake(0, 1630, pageWidth, 500)
        v1.addSubview(bottomBannerImg)
        
        // Add Store name to banner
        let siteText = UILabel(frame: CGRectMake(0, 1775, pageWidth, 225))
        siteText.text = "HD #\(storeInfo["storeNum"]!) \(storeInfo["storeName"]!)"
        siteText.textAlignment = NSTextAlignment.Center
        siteText.font = UIFont.systemFontOfSize(140)
        siteText.textColor = UIColor.darkGrayColor()
        v1.addSubview(siteText)
        
        // Add date to banner
        let fDate = UILabel(frame: CGRectMake(0, 1950, pageWidth, 125))
        fDate.text = storeInfo["date"]
        fDate.textAlignment = NSTextAlignment.Center
        fDate.font = UIFont.systemFontOfSize(65)
        fDate.textColor = UIColor.grayColor()
        v1.addSubview(fDate)
        
        return PDFPage.View(v1)
        
    }
    func photoSheetPage(storeInfo: [String: String]) -> PDFPage
    {
        let footerView = getFooter()
        
        let labelHeight: CGFloat = 217
        
        let padding = UIEdgeInsetsMake(71, 0, 0, 10)
        let photoSheetForm = UIView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
        photoSheetForm.backgroundColor = UIColor.whiteColor()
        photoSheetForm.addSubview(footerView)
        
        let topImg = UIImage(named: "topImg.png")
        let topImgView = UIImageView(image: topImg!)
        topImgView.frame = CGRectMake(89, 86, 2822, 385)
        photoSheetForm.addSubview(topImgView)
        
        let photoSheetTitle = UILabel(frame: CGRectMake(554, 570, 1900, labelHeight))
        photoSheetTitle.text = "Photo Sheet"
        photoSheetTitle.textAlignment = NSTextAlignment.Center
        photoSheetTitle.font = UIFont.boldSystemFontOfSize(100)
        photoSheetTitle.layer.borderColor = UIColor.blackColor().CGColor
        photoSheetTitle.layer.borderWidth = 1
        photoSheetForm.addSubview(photoSheetTitle)
        
        let label1 = UITextView(frame: CGRectMake(554, 787, 620, labelHeight))
        label1.textContainerInset = padding
        label1.text = "Store #:"
        label1.textAlignment = NSTextAlignment.Right
        label1.font = UIFont.boldSystemFontOfSize(75)
        label1.layer.borderColor = UIColor.blackColor().CGColor
        label1.layer.borderWidth = 1
        photoSheetForm.addSubview(label1)
        
        let storeNumText = UILabel(frame: CGRectMake(1174, 787, 1280, labelHeight))
        storeNumText.text = "  \(storeInfo["storeNum"]!)"
        storeNumText.textAlignment = NSTextAlignment.Left
        storeNumText.font = UIFont.systemFontOfSize(75)
        storeNumText.layer.borderColor = UIColor.blackColor().CGColor
        storeNumText.layer.borderWidth = 1
        photoSheetForm.addSubview(storeNumText)
        
        let label2 = UITextView(frame: CGRectMake(554, 1004, 620, labelHeight))
        label2.textContainerInset = padding
        label2.text = "Store Name:"
        label2.textAlignment = NSTextAlignment.Right
        label2.font = UIFont.boldSystemFontOfSize(75)
        label2.layer.borderColor = UIColor.blackColor().CGColor
        label2.layer.borderWidth = 1
        photoSheetForm.addSubview(label2)
        
        let storeNameText = UILabel(frame: CGRectMake(1174, 1004, 1280, labelHeight))
        storeNameText.text = "  \(storeInfo["storeName"]!)"
        storeNameText.textAlignment = NSTextAlignment.Left
        storeNameText.font = UIFont.systemFontOfSize(75)
        storeNameText.layer.borderColor = UIColor.blackColor().CGColor
        storeNameText.layer.borderWidth = 1
        photoSheetForm.addSubview(storeNameText)
        
        let label3 = UITextView(frame: CGRectMake(554, 1221, 620, labelHeight))
        label3.textContainerInset = padding
        label3.text = "Project Name:"
        label3.textAlignment = NSTextAlignment.Right
        label3.font = UIFont.boldSystemFontOfSize(75)
        label3.layer.borderColor = UIColor.blackColor().CGColor
        label3.layer.borderWidth = 1
        photoSheetForm.addSubview(label3)
        
        let projectNameText = UILabel(frame: CGRectMake(1174, 1221, 1280, labelHeight))
        projectNameText.text = "  \(storeInfo["projectName"]!)"
        projectNameText.textAlignment = NSTextAlignment.Left
        projectNameText.font = UIFont.systemFontOfSize(75)
        projectNameText.layer.borderWidth = 1
        projectNameText.layer.borderColor = UIColor.blackColor().CGColor
        photoSheetForm.addSubview(projectNameText)
        
        let label4 = UITextView(frame: CGRectMake(554, 1438, 620, labelHeight))
        label4.textContainerInset = padding
        label4.text = "Project Manager:"
        label4.textAlignment = NSTextAlignment.Right
        label4.font = UIFont.boldSystemFontOfSize(75)
        label4.layer.borderColor = UIColor.blackColor().CGColor
        label4.layer.borderWidth = 1
        photoSheetForm.addSubview(label4)
        
        let projectMngText = UILabel(frame: CGRectMake(1174, 1438, 1280, labelHeight))
        projectMngText.text = "  \(contactInfo["name"]!)"
        projectMngText.textAlignment = NSTextAlignment.Left
        projectMngText.font = UIFont.systemFontOfSize(75)
        projectMngText.layer.borderColor = UIColor.blackColor().CGColor
        projectMngText.layer.borderWidth = 1
        photoSheetForm.addSubview(projectMngText)
        
        let label5 = UITextView(frame: CGRectMake(554, 1655, 620, labelHeight))
        label5.textContainerInset = padding
        label5.text = "Date:"
        label5.textAlignment = NSTextAlignment.Right
        label5.font = UIFont.boldSystemFontOfSize(75)
        label5.layer.borderColor = UIColor.blackColor().CGColor
        label5.layer.borderWidth = 1
        photoSheetForm.addSubview(label5)
        
        let date = UILabel(frame: CGRectMake(1174, 1655, 1280, labelHeight))
        date.text = "  \(storeInfo["date"]!)"
        date.textAlignment = NSTextAlignment.Left
        date.font = UIFont.systemFontOfSize(75)
        date.layer.borderWidth = 1
        date.layer.borderColor = UIColor.blackColor().CGColor
        photoSheetForm.addSubview(date)
        
        return PDFPage.View(photoSheetForm)
    }

    func mainImgPage(img: UIImage) -> PDFPage
    {
        
        let footerView = getFooter()
        let mainImagePage = UIView(frame: CGRectMake(0, 0, 3000, 2250))
        mainImagePage.backgroundColor = UIColor.whiteColor()
        let mainImageView = UIImageView(image: img)
        mainImageView.frame = CGRectMake(384, 291.9, 2244, 1668)
        mainImagePage.addSubview(mainImageView)
        mainImagePage.addSubview(footerView)
        return PDFPage.View(mainImagePage)
    }
    
    func oddLastSmallImgPage(images: [UIImage]) -> PDFPage
    {
        print("img count from odd page func\(images.count)")
        let footerView = getFooter()
        let width: CGFloat = 942
        let height: CGFloat = 702
        let x1: CGFloat = 307.5
        let x2: CGFloat = 1749
        let y1: CGFloat = 394.5
        let y2: CGFloat = 1153.5
        let page = UIView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
        if images.count == 3
        {
            
            page.backgroundColor = UIColor.whiteColor()
            let img1 = UIImageView(image: images[0])
            let img2 = UIImageView(image: images[1])
            let img3 = UIImageView(image: images[2])
            img1.frame = CGRectMake(x1, y1, width, height)
            img2.frame = CGRectMake(x2, y1, width, height)
            img3.frame = CGRectMake(x1, y2, width, height)
            page.addSubview(img1)
            page.addSubview(img2)
            page.addSubview(img3)
            page.addSubview(footerView)
            
        }
        else if images.count == 2
        {
            
            page.backgroundColor = UIColor.whiteColor()
            let img1 = UIImageView(image: images[0])
            let img2 = UIImageView(image: images[1])
            img1.frame = CGRectMake(x1, y1, width, height)
            img2.frame = CGRectMake(x2, y1, width, height)
            page.addSubview(img1)
            page.addSubview(img2)
            page.addSubview(footerView)
            
        }
        else if images.count == 1
        {
            
            page.backgroundColor = UIColor.whiteColor()
            let img = UIImageView(image: images[0])
            img.frame = CGRectMake(x1, y1, width, height)
            page.addSubview(img)
            page.addSubview(footerView)
            
        }
        return PDFPage.View(page)
    }
    
    func smallImgPages(images: [UIImage]) -> [PDFPage]
    {
        print("img func w count of \(images.count)")
        var pagesToReturn = [PDFPage]()
        let width: CGFloat = 942
        let height: CGFloat = 702
        let x1: CGFloat = 307.5
        let x2: CGFloat = 1749
        let y1: CGFloat = 394.5
        let y2: CGFloat = 1153.5
        for (i, img) in images.enumerate()
        {
            
            if (images.count - i) < 4
            {
                break
            }
            else if i % 4 == 0 || i == 0
            {
                let footerView = getFooter()
                let page = UIView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
                page.backgroundColor = UIColor.whiteColor()
                let img1 = UIImageView(image: img)
                let img2 = UIImageView(image: images[i + 1])
                let img3 = UIImageView(image: images[i + 2])
                let img4 = UIImageView(image: images[i + 3])
                img1.frame = CGRectMake(x1, y1, width, height)
                img2.frame = CGRectMake(x2, y1, width, height)
                img3.frame = CGRectMake(x1, y2, width, height)
                img4.frame = CGRectMake(x2, y2, width, height)
                page.addSubview(img1)
                page.addSubview(img2)
                page.addSubview(img3)
                page.addSubview(img4)
                print(footerView)
                page.addSubview(footerView)
                let pagePDF = PDFPage.View(page)
                pagesToReturn.append(pagePDF)
                
            }
        }
        return pagesToReturn
    }
        
    
    func finalPage() -> PDFPage
    {
        print("in final page function")
        
        let lastPage = UIView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
        lastPage.backgroundColor = UIColor.whiteColor()
        let finalImg = UIImageView(frame: CGRectMake(75, 60, 2850, 1500))
        finalImg.image = UIImage(named: "endImg.png")
        lastPage.addSubview(finalImg)
        let bottomBanner = UIImage(named: "bottomBanner.png")
        let bottomBannerImg = UIImageView(image: bottomBanner)
        bottomBannerImg.frame = CGRectMake(0, 1630, pageWidth, 500)
        lastPage.addSubview(bottomBannerImg)
        
        let contactName = UILabel(frame: CGRectMake(1225, 1700, 1750, 65))
        contactName.text = "\(contactInfo["name"]!)"
        contactName.textColor = UIColor.darkGrayColor()
        contactName.font = UIFont.boldSystemFontOfSize(55)
        contactName.textAlignment = NSTextAlignment.Left
        lastPage.addSubview(contactName)
        
        let phonePrefix = UILabel(frame: CGRectMake(1225, 1775, 50, 65))
        phonePrefix.textAlignment = NSTextAlignment.Left
        phonePrefix.text = "c"
        phonePrefix.font = UIFont.boldSystemFontOfSize(55)
        phonePrefix.textColor = UIColor.darkGrayColor()
        lastPage.addSubview(phonePrefix)
        
        let contactPhone = UILabel(frame: CGRectMake(1270, 1775, 1700, 65))
        contactPhone.text = contactInfo["phoneNum"]!
        contactPhone.textColor = UIColor.grayColor()
        contactPhone.font = UIFont.systemFontOfSize(55)
        contactPhone.textAlignment = NSTextAlignment.Left
        lastPage.addSubview(contactPhone)
        
        let contactEmail = UILabel(frame: CGRectMake(1225, 1850, 1750, 65))
        contactEmail.text = contactInfo["email"]!
        contactEmail.textColor = UIColor.grayColor()
        contactEmail.font = UIFont.systemFontOfSize(55)
        contactEmail.textAlignment = NSTextAlignment.Left
        lastPage.addSubview(contactEmail)
        
        return PDFPage.View(lastPage)
        
    }
    
    func notesPage(notes: [String], notesTitle: String?) -> [PDFPage]
    {
        var notesPagesToReturn = [PDFPage]()
        print("title from model \(notesTitle)")
        let footerView = getFooter()

        let noteHeight:CGFloat = 150
        var noteYAxis:CGFloat = 600
        let notePage1 = UIView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
        notePage1.backgroundColor = UIColor.whiteColor()
        
        let topImg = UIImage(named: "topImg.png")
        let topImgView = UIImageView(image: topImg!)
        topImgView.frame = CGRectMake(89, 86, 2822, 385)
        
        notePage1.addSubview(footerView)
        notePage1.addSubview(topImgView)
        if let titleText = notesTitle
        {
            
            let titleLabel = UILabel(frame: CGRectMake(89, 86, 2822, 385))
            titleLabel.text = titleText
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.font = UIFont.boldSystemFontOfSize(150)
            titleLabel.textAlignment = NSTextAlignment.Center
            notePage1.addSubview(titleLabel)
        }
        for note in notes
        {
            
            let bulletPointLabel = UILabel(frame: CGRectMake(150, noteYAxis - 15, 50, noteHeight))
            bulletPointLabel.text = "\u{2022}"
            bulletPointLabel.textColor = UIColor.redColor()
            bulletPointLabel.font = UIFont.systemFontOfSize(100)
            notePage1.addSubview(bulletPointLabel)
            let noteLabel = UILabel(frame: CGRectMake(210, noteYAxis, 2711, noteHeight))
            noteLabel.text = note
            noteLabel.font = UIFont.systemFontOfSize(100)
            noteLabel.textAlignment = NSTextAlignment.Left
            noteLabel.textColor = UIColor.darkGrayColor()
            noteLabel.numberOfLines = 0
            noteLabel.sizeToFit()
            notePage1.addSubview(noteLabel)
            let labelHeight = noteLabel.frame.height
            noteYAxis += labelHeight + 23
            
        }
        notesPagesToReturn.append(PDFPage.View(notePage1))
        return notesPagesToReturn
        
    }
    
//    func summaryPage(summary: String) -> PDFPage
//    {
//        let summaryView = UIView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
//        summaryView.backgroundColor = UIColor.whiteColor()
//        
//        let topImg = UIImage(named: "topImg.png")
//        let topImgView = UIImageView(image: topImg!)
//        topImgView.frame = CGRectMake(89, 86, 2822, 385)
//        summaryView.addSubview(topImgView)
//        
//        let footerImg = UIImage(named: "footer.png")
//        let footerView = UIImageView(image: footerImg!)
//        footerView.frame = CGRectMake(0, 1980, 1800, 270)
//        summaryView.addSubview(footerView)
//        
//        let summaryLabel = UILabel(frame: CGRectMake())
//    }
    
}
