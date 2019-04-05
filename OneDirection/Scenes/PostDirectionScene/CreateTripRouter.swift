//
//  CreateTripRouter.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/15/19.
//  Copyright (c) 2019 Ashish  Nautiyal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol CreateTripRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CreateTripDataPassing
{
    var dataStore: CreateTripDataStore? { get }
}

class CreateTripRouter: NSObject, CreateTripRoutingLogic, CreateTripDataPassing
{
    weak var viewController: CreateTripViewController?
    var dataStore: CreateTripDataStore?
}