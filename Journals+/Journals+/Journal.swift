//
//  Journal.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/2/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

class Journal {

    var journalEntries:[JournalEntry] = []

    var name:String?
    var lastEditDate:String?
    
    var folderName:String?
    var filteredColorImage:String?

    init(journalName:String) {
        self.name = journalName
    }
    
    convenience init(journalName:String, imageURL:String) {
        
        self.init(journalName: journalName)
        self.folderName = imageURL;
    }
    
    var thumbCoverImage:UIImage? {
        get {
            
            
            let thumbURL = self.folderName! + "/" +  "coverimagethumb.jpg"
           
            let documentsDir:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            
            let thumbFullURL =  documentsDir.appendingPathComponent(thumbURL)

            let data = try? Data(contentsOf: thumbFullURL)
            
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                
                return image

            }
            
            return nil
            
        }
    }
    
        

}
