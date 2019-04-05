//
//  CommentTabelCell.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 4/4/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
import  UIKit
class CommentTabelCell: UITableViewCell{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var initialLabel: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        initialLabel.layer.backgroundColor  = TripModel.colorList[ Int(arc4random_uniform(UInt32(TripModel.colorList.count)))]
        initialLabel.layer.cornerRadius = 25
        
    }
}
