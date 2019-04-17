//
//  RequestBookingTableCell.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/20/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
import UIKit
class RequestBookingTableCell : UITableViewCell{
 
    @IBOutlet weak var ticketButton: UIButton!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var initialLabel: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
       initialLabel.layer.backgroundColor  = TripModel.colorList[ Int(arc4random_uniform(UInt32(TripModel.colorList.count)))]
        initialLabel.layer.cornerRadius = 25
        ticketButton.contentMode = .center
        ticketButton.imageView?.contentMode = .scaleAspectFit
    }
}
