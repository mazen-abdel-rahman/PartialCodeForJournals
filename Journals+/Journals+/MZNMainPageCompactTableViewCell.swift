//
//  MZNMainPageCompactTableViewCell.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 1/30/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

class MZNMainPageCompactTableViewCell: UITableViewCell, MainPageCellInfo {

    @IBOutlet weak var journalCoverImage: UIImageView!
    @IBOutlet weak var journalName: UILabel!
    @IBOutlet weak var lastEditDate: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
