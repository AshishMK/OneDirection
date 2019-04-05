//
//  DataManager.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/17/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class TripModel {
    static var tripList = [Trip]()
     static var myTripList = [Trip]()
    static var myTripRequestList = [TripRequest]()
    static var tripRequestList = [TripRequest]()
    static var tripComments = [Comment]()
    static var mapRoute =  [String:MKDirectionsResponse]()
    static var colorList : [CGColor] = [UIColor.red.cgColor,UIColor.blue.cgColor,UIColor.green.cgColor,UIColor.magenta.cgColor]
}
