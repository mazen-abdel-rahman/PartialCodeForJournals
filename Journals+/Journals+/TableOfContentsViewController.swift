//
//  TableOfContentsViewController.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/1/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

class TableOfContentsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionView:UICollectionView?

    
    var journal:Journal = Journal(journalName: "")
    
    
    struct ThemeBackgroundColor {
        var redValue:CGFloat
        var greenValue:CGFloat
        var blueValue:CGFloat
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView .register(TableOfContentsTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.automaticallyAdjustsScrollViewInsets = true;
        
        self.title = journal.name
        
        print("Before blurring \(NSDate())")
        
//        let blurredImage = applyGaussianBlurFilter(to: journal.coverImage!)
        
        print("After blurring \(NSDate())")
        
        let backgroundColor = ThemeBackgroundColor(redValue: 170.0/255.0, greenValue: 230.0/255.0, blueValue: 146.0/255.0)
//        let filteredImage = applyMonochromaticFilter(to: blurredImage!, backgroundColor: backgroundColor)
        
//        let bgImageView = UIImageView(image:UIImage(named:journal.coverImageURL!))
//        self.collectionView?.backgroundView = bgImageView;
        
//        self.tableView.backgroundView = bgImageView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- Table View Data Source and Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal.journalEntries.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentCell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        
        currentCell.textLabel?.text = self.journal.journalEntries[indexPath.row].title
        currentCell.detailTextLabel?.text = "The Shire was a peaceful hobbit village next to Buckland."
        currentCell.backgroundColor = UIColor.clear
        currentCell.textLabel?.textColor = UIColor(red: 230.0/255.0, green: 146.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        currentCell.detailTextLabel?.textColor = UIColor(red: 230.0/255.0, green: 146.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        
        return currentCell;
    }
    
    //MARK:- Collection View Data Source and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journal.journalEntries.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell:MZNCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MZNCollectionViewCell;
        
        currentCell.journalName.text = self.journal.journalEntries[indexPath.row].title
        //        currentCell. = cellData.lastEditDate
//        currentCell.journalCoverImage.image = cellData.coverImage
        
//        applyMaskToCoverImageView(coverImageView: currentCell.journalCoverImage)
        
        return currentCell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath)->(CGSize) {
        
        
        let collectionViewWidth:CGFloat =  (self.collectionView?.frame.size.width)!
        let collectionViewHeight:CGFloat = (self.collectionView?.frame.size.height)!
        
        var cellWidth:CGFloat
        if collectionViewWidth > collectionViewHeight {
            cellWidth  =  (self.collectionView?.frame.size.width)! / 3 - 10;
        } else {
            cellWidth  =  (self.collectionView?.frame.size.width)! / 2 - 10;
        }
        
        
        let  cellHeight:CGFloat = 136;
        
        return CGSize(width: cellWidth, height: cellHeight)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        
        let collectionViewWidth:CGFloat =  (self.collectionView?.frame.size.width)!
        let collectionViewHeight:CGFloat = (self.collectionView?.frame.size.height)!
        
        var minimumInterSpacing:CGFloat
        if collectionViewWidth > collectionViewHeight {
            minimumInterSpacing  =  10;
        } else {
            minimumInterSpacing  =  10;
        }
        
        return minimumInterSpacing;
        
    }
    
    
    
    //MARK:- Helper Methods
    func applyMaskToCoverImageView(coverImageView:UIImageView) {
        
        let maskLayer = CALayer()
        let maskImage = UIImage(named: "mask")
        maskLayer.contents = maskImage?.cgImage
        maskLayer.frame = CGRect(x: 0.0, y: 0.0, width: (maskImage?.size.width)!, height: (maskImage?.size.height)!)
        coverImageView.layer.mask = maskLayer
        coverImageView.layer.masksToBounds = true
        coverImageView.contentMode = .scaleAspectFill
        
        
        
        
    }
    
    func applyMonochromaticFilter(to image:UIImage, backgroundColor:ThemeBackgroundColor) -> UIImage? {
        
        let context = CIContext(options: nil)
        let ciImage2 = CoreImage.CIImage(image: image)
    
        let ciImage = ciImage2!
        
        // Set image color to b/w
        let bwFilter = CIFilter(name: "CIColorMonochrome")!
        bwFilter.setValuesForKeys(([kCIInputImageKey:ciImage, kCIInputColorKey:CIColor.init(red: backgroundColor.redValue, green: backgroundColor.greenValue, blue: backgroundColor.blueValue), kCIInputIntensityKey:NSNumber(value: 1.0)]))
        
        let bwFilterOutput = (bwFilter.outputImage)!
        
        
        let imageA = UIImage(ciImage: bwFilterOutput)
        
        
        
        // Create UIImage from context
//        let bwCGIImage = context.createCGImage(bwFilterOutput, from: ciImage.extent)
//        let resultImage = UIImage(cgImage: bwCGIImage!, scale: 1.0, orientation: image.imageOrientation)
        
        return imageA
    }
    
    func applyGaussianBlurFilter(to image:UIImage) -> UIImage? {
        
        let context = CIContext(options: nil)
        let ciImage = CoreImage.CIImage(image: image)!
        
        // Set image color to b/w
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValuesForKeys(([kCIInputImageKey:ciImage, kCIInputRadiusKey:NSNumber(value: 30.0)]))
        
        let blurFilterOutput = (blurFilter.outputImage)!
        
        
        let imageA = UIImage(ciImage: blurFilterOutput)

        
        
        // Create UIImage from context
//        let blurCGIImage = context.createCGImage(blurFilterOutput, from: ciImage.extent)
//        let resultImage = UIImage(cgImage: blurCGIImage!, scale: 1.0, orientation: image.imageOrientation)
        
        return imageA
        
    }


   
}
