//
//  MainPageCellInfo.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/2/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

protocol MainPageCellInfo {
    var journalCoverImage: UIImageView! { get set }
    var journalName: UILabel! { get set }
    var lastEditDate: UILabel! { get set }

}
