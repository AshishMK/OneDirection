//
//  TripRequestsRouter.swift
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

@objc protocol TripRequestsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol TripRequestsDataPassing
{
  var dataStore: TripRequestsDataStore? { get }
}

class TripRequestsRouter: NSObject, TripRequestsRoutingLogic, TripRequestsDataPassing
{
  weak var viewController: TripRequestsViewController?
  var dataStore: TripRequestsDataStore?
}
