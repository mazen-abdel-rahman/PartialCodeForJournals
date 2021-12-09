//
//  TableOfContentsTableViewCell.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/1/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

class TableOfContentsTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
