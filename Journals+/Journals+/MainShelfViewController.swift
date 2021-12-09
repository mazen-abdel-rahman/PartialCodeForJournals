//
//  ViewController.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 1/20/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit
import CoreGraphics
import Security

class MainShelfViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionView:UICollectionView?
    
    var journals:[Journal] = []
    var selectedCellIndexPath:IndexPath?
    
     
    
    public let flipPresentAnimationController = ShelfToTableOfContentsAnimationController()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView .register(MZNMainPageCompactTableViewCell.self, forCellReuseIdentifier: "cell");
        
        self.title = "Journals Plus"
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.navigationController?.delegate = appDelegate.transitionController
        
        
        populateBookshelf()
        
//        addSecurity()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        NSLog("I am here")
        
        self.collectionView?.reloadData()
    }
    
    //MARK:- Table View Data Source and Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentCell:MZNMainPageCompactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MainPageJournalCellCompact", for: indexPath) as! MZNMainPageCompactTableViewCell;
        
//        let cellData = dataForCurrentCell(indexPath: indexPath);
        currentCell.journalName.text = journals[indexPath.row].name
        currentCell.lastEditDate.text = journals[indexPath.row].lastEditDate
        currentCell.journalCoverImage.image = journals[indexPath.row].thumbCoverImage

        

        
        //Transform to reduce size CILanczosScaleTransform
        
        applyMaskToCoverImageView(coverImageView: currentCell.journalCoverImage)
        
        
        
        return currentCell;
    }
    
//MARK:- Collection View Data Source and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journals.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell:MZNCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MZNCollectionViewCell;
        
        currentCell.journalName.text = journals[indexPath.row].name
        currentCell.lastEditDate.text = journals[indexPath.row].lastEditDate
        currentCell.journalCoverImage.image = journals[indexPath.row].thumbCoverImage
        
    
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
    
    
//MARK:- Data Source 

    func populateSampleData() {
//        let book1 = Journal(journalName: "The Hobbit")
//        book1.coverImageURL = URL(fileURLWithPath: "fiji")
//       
//        book1.lastEditDate = "Feb 2, 2018"
//        
//        let je1 = JournalEntry()
//        je1.title = "A Party of Dwarves"
//        je1.body = "Bilbo hosted the dwarves at his home, and gave them great food."
//        book1.journalEntries.append(je1)
//        
//        let je2 = JournalEntry()
//        je2.title = "Trolls"
//        je2.body = "The saw the trolls."
//        book1.journalEntries.append(je2)
//        
//        
//        let je3 = JournalEntry()
//        je3.title = "Rivendale"
//        je3.body = "They get to meet Elrond and learn about the ancient runes."
//        book1.journalEntries.append(je3)
//        
//        let je4 = JournalEntry()
//        je4.title = "Mirkwood Forest"
//        je4.body = "They are captured by the elves."
//        book1.journalEntries.append(je4)
//        
//        
//        
//        let book2 = Journal(journalName: "Lord of the Rings")
//        book2.coverImageURL = URL(fileURLWithPath: "Yellowstone")
//
//        book2.lastEditDate = "Feb 2, 2018"
//        
//        let book3 = Journal(journalName: "The Silmarillion")
//        book3.coverImageURL = URL(fileURLWithPath: "GrandCanyon")
//        book3.lastEditDate = "Feb 2, 2018"
//        
//        let book4 = Journal(journalName: "Farmer Giles")
//        book4.coverImageURL = URL(fileURLWithPath: "defaultCoverImage")
//        book4.lastEditDate = "Feb 2, 2018"
//        
//        journals.append(contentsOf: [book1, book2, book3, book4])

    }
    
    
    func populateBookshelf() {
        
        
        guard let books = UserDefaults.standard.array(forKey: Constants.UserDefaultKeys.AllJournals) else {
            return
        }
        
    
        for journal in (books as? [Dictionary<String, String>])! {
            
            let book = Journal(journalName: journal[Constants.UserDefaultKeys.JournalName]!)
            
            book.folderName = journal[Constants.UserDefaultKeys.JournalCoverURL]            
            
            journals.append(book)
            
        }
        
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC:TableOfContentsViewController = segue.destination as! TableOfContentsViewController
        
        
        guard let indexPathForSelectedCell = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        self.selectedCellIndexPath = indexPathForSelectedCell
        
        destinationVC.journal = self.journals[self.selectedCellIndexPath!.row]
    
    }
    
    func addSecurity() {
        let topSecret:String = "Top Secret"
        let secretData = topSecret.data(using: .utf8)
        
        var query:Dictionary = [String:Any]()
        
        
        query[kSecClass as String] = kSecClassGenericPassword as String
        query[kSecAttrService as String] = "MyService"
        query[kSecAttrAccount as String] = "Sanctions" //"Account Name Here"
        query[kSecValueData as String] = secretData
        
        
        var accessControlError:UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
        // ^ Already a 'pointer'
        
        
        let sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                    kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                    SecAccessControlCreateFlags.userPresence,
                                                    accessControlError )
        
        
        
        query[kSecAttrAccessControl as String] = sacObject
        
        var error: AnyObject?
        
        let status:OSStatus = SecItemAdd(query as CFDictionary, &error)
        
        
        switch status {
        case errSecSuccess:
              print("It worked!")
        case errSecUnimplemented:
              print("errSecUnimplemented")
        case errSecIO:
            print("errSecIO")
        case errSecOpWr:
            print("errSecOpWr")
        case errSecParam:
            print("errSecParam")
        case errSecAllocate:
            print("errSecAllocate")
        case errSecUserCanceled:
            print("errSecUserCanceled")
        case errSecBadReq:
            print("errSecBadReq")
        case errSecInternalComponent:
            print("errSecInternalComponent")
        case errSecNotAvailable:
            print("errSecNotAvailable")
        case errSecDuplicateItem:
            print("errSecDuplicateItem")
        case errSecItemNotFound:
            print("Item not found")
        case errSecInteractionNotAllowed:
            print("errSecInteractionNotAllowed")
        case errSecDecode:
            print("errSecDecode")
        case errSecAuthFailed:
                print("errSecAuthFailed")
        case errSecVerifyFailed:
            print("errSecVerifyFailed")

        default:
            print("Something else found")
        }
        
        
        
        if (status == errSecSuccess) {
            print("It worked!")
        } else {
            print("It did not work")
        }
        
        
        errSecSuccess
        
       print("Status of keychain operation is \(status)")
        
    }
    
    func querySecurity()->OSStatus {
        
        var query:Dictionary = [String:Any]()
        
        
        query[kSecClass as String] = kSecClassGenericPassword as String
        query[kSecAttrService as String] = "MyService"
        query[kSecAttrAccount as String] = "Account Name Here"
        query[kSecReturnData as String] = true
        query[kSecUseOperationPrompt as String] = "Authenticate to View More Homes"
        
        //            var result: AnyObject?
        //            let status = SecItemCopyMatching(query as CFDictionary, &result)
        //                print("Result returned")
        
    
        return errSecSuccess
        
    }
    
//MARK: - Actions
    
    @IBAction func addNewJournal(_ sender: UIBarButtonItem) {
        
        let securityStatus =  querySecurity()
        
        DispatchQueue.main.async {

            if (securityStatus == errSecSuccess) {
                let addJournalSB = UIStoryboard(name: "AddJournal", bundle: nil)
                
                let initialVC:UINavigationController? = addJournalSB.instantiateInitialViewController() as? UINavigationController
                
                guard let vc = initialVC else {
                
                    return
                }
                
                let nameVC:SetJournalNameVC? =  vc.topViewController as? SetJournalNameVC
                
                guard let setNameVC = nameVC else {
                    return
                }
                
                setNameVC.createJournalPageFinished = {
                    [weak self] in
                    
                    //This is a hack
                    self?.journals.removeAll()
                    self?.populateBookshelf()
                    
                    
                    self?.tableView.reloadData();
                    self?.collectionView?.reloadData();
                    
                    self?.dismiss(animated: true, completion: nil)
                }
                
                
                
                self.present(vc, animated: true) {
                    
                    NSLog("IT is here")
                }

            } else {
                let alertController  = UIAlertController(title: "Log In Required", message: "You are not authenticated, so permission is denied", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    //
                })
                
                alertController.addAction(action)
                
                self.present(alertController, animated: true, completion: {
                    //
                })
            }
        }
        
      
        

        
        
        
        
    }

    
}
