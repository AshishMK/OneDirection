//
//  TripRequestsPresenter.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/22/19.
//  Copyright (c) 2019 Ashish  Nautiyal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TripRequestsPresentationLogic
{
    func updateBookingstatus(success: Bool, message: String,posintion: Int)
func presentList(tripRequests: [TripRequest], error: Error?)
}

class TripRequestsPresenter: TripRequestsPresentationLogic
{
  weak var viewController: TripRequestsDisplayLogic?
  
  // MARK: Do something
    func updateBookingstatus(success: Bool, message: String,posintion: Int) {
        viewController?.updateBookingStatus(success: success, message: message, posintion: posintion)
    }
    
    func presentList(tripRequests: [TripRequest], error: Error?)
    {
        viewController?.displayTripRequest(tripRequest: tripRequests, error: error)
    }
}
