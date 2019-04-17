//
//  MyTripTableCell.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/23/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
import MapKit
import  UIKit
class MyTripTableCell: UITableViewCell, MKMapViewDelegate {
 
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ticketButton: UIButton!
    @IBOutlet weak var countTextLabel: UILabel!
    
    @IBOutlet weak var userInfoStackView: UIStackView!
    override func layoutSubviews() {
        super.layoutSubviews()
        ticketButton.contentMode = .center
        ticketButton.imageView?.contentMode = .scaleAspectFit

    }
    func mapView(_ mapView: MKMapView, rendererFor
        overlay: MKOverlay) -> MKOverlayRenderer {
        print("gett route fot renderer")
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 1.0
        return renderer
    }
    
    
    override func awakeFromNib() {
    super.awakeFromNib()
    // Initialisation code
        initialLabel.layer.backgroundColor  = TripModel.colorList[ Int(arc4random_uniform(UInt32(TripModel.colorList.count)))]
        initialLabel.layer.cornerRadius = 25
    //MapView
    mapView!.showsPointsOfInterest = true
    if let mapView = self.mapView
        {
            mapView.delegate = self
    }
}
}
