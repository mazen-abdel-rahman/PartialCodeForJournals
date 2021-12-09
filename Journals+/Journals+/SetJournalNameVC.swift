//
//  SetJournalNameVC.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/13/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreGraphics


struct ThemeBackgroundColor {
    var redValue:CGFloat
    var greenValue:CGFloat
    var blueValue:CGFloat
}


class SetJournalNameVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImageView: UIImageView!
    
    @IBOutlet weak var previewTextViewBackgroundImage: UIImageView!
    @IBOutlet weak var previewTextView: UITextView!
    
 
    @IBOutlet weak var nameTextField: UITextField!
   
    var coverImageThumb:UIImage?
    var coverImageBackground:UIImage?
    var coverImageOriginal:UIImage?
    
    let journalThumbCoverDimension:CGFloat = 48.0

    var themeDict = [[String:Any]]()
    var selectedTheme:[String:Any]?
    

    var createJournalPageFinished:(() ->())?
    
    
    var pictureURL:URL {
        get {
            let documentsDir:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            let picDir = documentsDir.appendingPathComponent("pictures")
            
            do {
                try  FileManager.default.createDirectory(at: picDir, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print("Failed with error \(error)")
            }
            
            return picDir
        }
        
        set (newValue) {
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let theme1Background = ThemeBackgroundColor(redValue: 181.0/255.0, greenValue: 196.0/255.0, blueValue: 139.0/255.0)
        let theme1Text = UIColor(red: 39.0/255.0, green: 43.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        
        
        let theme2Background = ThemeBackgroundColor(redValue: 235.0/255.0, greenValue: 235.0/255.0, blueValue: 235.0/255.0)
        let theme2Text = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
        
        let theme3Background = ThemeBackgroundColor(redValue: 16.0/255.0, greenValue: 60.0/255.0, blueValue: 84.0/255.0)
        let theme3Text = UIColor.white

        let theme1Dict:[String:Any] = ["Background":theme1Background, "Text":theme1Text]
        let theme2Dict:[String:Any] = ["Background":theme2Background, "Text":theme2Text]
        let theme3Dict:[String:Any] = ["Background":theme3Background, "Text":theme3Text]

        themeDict = [theme1Dict, theme2Dict, theme3Dict]
        
        selectedTheme = themeDict[0]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
let ip = IndexPath(row: 1, section: 0)
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case IndexPath(row: 1, section: 0):
            presentPhotoPicker()
        default:
            break
        }
        
        
    }
    
    
    
    func presentPhotoPicker() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: { 
                //
            })
            
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   
        //Get image data
        self.coverImageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        
        self.selectedImageView.contentMode = .scaleAspectFill
        self.selectedImageView.clipsToBounds = true
        
        self.coverImageThumb = self.coverImageOriginal?.resizeAndKeepAspectRatio(to: self.journalThumbCoverDimension, scale: 2.0, isMaxDimension: false)
    
        let screenSize = UIScreen.main.bounds.size
        
        self.coverImageBackground = self.coverImageOriginal?.resizeAndKeepAspectRatio(to: screenSize.height > screenSize.width ? screenSize.height : screenSize.width, scale:2.0, isMaxDimension: true)
        
        //let singleColorImage = applyMonochromaticFilter(to: self.coverImageBackground!, backgroundColor: ThemeBackgroundColor(redValue: 1.0, greenValue: 1.0, blueValue: 1.0))
        
        applySelectedTheme()
        
        self.dismiss(animated: true) {
            //
        }
        
    }
    
    
    func applyMonochromaticAndBlurFilter(to image:UIImage, backgroundColor:ThemeBackgroundColor) -> UIImage? {
        
        let context = CIContext(options: nil)
        let ciImage2 = CoreImage.CIImage(image: image)
        
        let ciImage = ciImage2!
        
        // Set image color to b/w
        let bwFilter = CIFilter(name: "CIColorMonochrome")!
        bwFilter.setValuesForKeys(([kCIInputImageKey:ciImage, kCIInputColorKey:CIColor.init(red: backgroundColor.redValue, green: backgroundColor.greenValue, blue: backgroundColor.blueValue), kCIInputIntensityKey:NSNumber(value: 1.0)]))
        
        let bwFilterOutput = (bwFilter.outputImage)!
        
       
        // Set image color to b/w
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValuesForKeys(([kCIInputImageKey:bwFilterOutput, kCIInputRadiusKey:NSNumber(value: 25.0)]))
            
        let blurFilterOutput = (blurFilter.outputImage)!
        
        // Create UIImage from context
        let bwCGIImage = context.createCGImage(blurFilterOutput, from: ciImage.extent)
        let resultImage = UIImage(cgImage: bwCGIImage!, scale: 1.0, orientation: image.imageOrientation)
        
        return resultImage
    }

    
    func applyMonochromaticFilter(to image:UIImage, backgroundColor:ThemeBackgroundColor) -> UIImage? {
        
        let context = CIContext(options: nil)
        let ciImage2 = CoreImage.CIImage(image: image)
        
        let ciImage = ciImage2!
        
        // Set image color to b/w
        let monochromaticFilter = CIFilter(name: "CIColorMonochrome")!
        monochromaticFilter.setValuesForKeys(([kCIInputImageKey:ciImage, kCIInputColorKey:CIColor.init(red: backgroundColor.redValue, green: backgroundColor.greenValue, blue: backgroundColor.blueValue), kCIInputIntensityKey:NSNumber(value: 1.0)]))
        
        let monochromaticFilterOutput = (monochromaticFilter.outputImage)!
        
        
        // Create UIImage from context
        let bwCGIImage = context.createCGImage(monochromaticFilterOutput, from: ciImage.extent)
        let resultImage = UIImage(cgImage: bwCGIImage!, scale: 1.0, orientation: image.imageOrientation)
        
        return resultImage
    }

    
    

    
    //MARK: - Helper Methods
    func GetUUID()->String {
        let uuidString = UUID().uuidString
        
        return uuidString
    }
    
    func scaleFactor(for image:UIImage, to destinationSize:CGSize)->(CGFloat) {
        
        let originalImageWidth = image.size.width
        let orignalImageHeight = image.size.height
        
        let widthRatio = originalImageWidth/48
        let heighRatio = orignalImageHeight/48
        
        var inputScale = (widthRatio < heighRatio) ? 1/widthRatio:1/heighRatio
        
        inputScale = 0.70
        
        return inputScale

    }
    
    @IBAction func cancelAddingJournal(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func fullDocumentURL(for relativeURLString:String)->URL {
        
        let documentsDir:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        
        return documentsDir.appendingPathComponent(relativeURLString)
        
    }
    
    @IBAction func createJournal(_ sender: UIBarButtonItem) {
    
        //Save selected cover images to disc
        //Get destination URL to save picture
       
        let journalFolderName = self.GetUUID()
    
        let thumbURL = journalFolderName + "/" +  "coverimagethumb.jpg"
        let coverImageOriginalURL = journalFolderName + "/" +  "coverImageOriginalURL.jpg"
        let coverImageBackgroundURL = journalFolderName + "/" +  "coverImageBackgroundURL.jpg"
        

        if let thumb = self.coverImageThumb {
            
            let thumbData = thumb.jpegData(compressionQuality: 1.0)
            let fullURL = fullDocumentURL(for: thumbURL)
            do {
                
                
             try  FileManager.default.createDirectory(at: fullDocumentURL(for: journalFolderName), withIntermediateDirectories: true, attributes: nil)
               
                
             try   thumbData?.write(to:fullURL, options: Data.WritingOptions.completeFileProtection)
            } catch let error  {
            
                print("An error occured.  The error is \(error.localizedDescription)")
            }
            
        }
        
        if let originalImage = self.coverImageOriginal {
            let originalImageData = originalImage.jpegData(compressionQuality: 1.0)
            
            do {
                try   originalImageData?.write(to: fullDocumentURL(for: coverImageOriginalURL), options: Data.WritingOptions.completeFileProtection)
            } catch let error  {
                print("An error occured.  The error is \(error.localizedDescription)")

            }

            
            
            
        }
        
        if let backgroundImage  = self.coverImageBackground {
            let backgroundImageData = backgroundImage.jpegData(compressionQuality: 1.0)
            
            do {
                try   backgroundImageData?.write(to: fullDocumentURL(for: coverImageBackgroundURL), options: Data.WritingOptions.completeFileProtection)
            } catch let error  {
                print("An error occured.  The error is \(error.localizedDescription)")

            }

        }
        
        
        
       var allJournals =  UserDefaults.standard.array(forKey: Constants.UserDefaultKeys.AllJournals)
        
        let newJournalDict:[String:String] = [Constants.UserDefaultKeys.JournalName:self.nameTextField.text!, Constants.UserDefaultKeys.JournalCoverURL:journalFolderName]
        
        if allJournals == nil {
            allJournals = []
        }
        
        allJournals?.append(newJournalDict)
        
        UserDefaults.standard.set(allJournals, forKey: Constants.UserDefaultKeys.AllJournals)
        UserDefaults.standard.synchronize()
        
        //Added Dec 8, 2021 by Mazen Abdel-Rahman
        if let finishBlock = createJournalPageFinished {
            finishBlock()
        }
        
        
    }
    
    
    @IBAction func setTheme1(_ sender: UIButton) {
        
        selectedTheme = themeDict[0]
        applySelectedTheme()
        
    }
    
    @IBAction func setTheme2(_ sender: UIButton) {
        selectedTheme = themeDict[1]
        applySelectedTheme()
    }
    
    @IBAction func setTheme3(_ sender: Any) {
        selectedTheme = themeDict[2]
        applySelectedTheme()
    }
    
    func applySelectedTheme() {
        
        
       
        let singleColorImage =  applyMonochromaticFilter(to: (self.coverImageBackground?.applyLightEffect())!,
                                                         backgroundColor: selectedTheme?["Background"] as! ThemeBackgroundColor )
        
        //       let bgImageViewForPreviewArea = UIImageView(image: singleColorImage!)
        
        self.previewTextViewBackgroundImage.image = singleColorImage;
        self.previewTextViewBackgroundImage.contentMode = .scaleAspectFill
        
        self.previewTextView.textColor = selectedTheme?["Text"] as! UIColor?
        
        self.selectedImageView.image = self.coverImageThumb
        self.selectedImageView.backgroundColor = UIColor.red
        self.selectedImageView.tintColor = UIColor.red
    }
    
    
}
