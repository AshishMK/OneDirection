//
//  CreateTripModels.swift
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
import Foundation
enum CreateTrip
{
  // MARK: Use cases
  
  
    struct Request
    {
        let uid : String
        let title : String
        let description : String
        let latStart : String
        let longStart : String
        let latEnd : String
        let longEnd : String
        let pals : String
        let startsDate : String
        let endDate: String
        
    }
    struct Response : Codable
    {
        let success: Bool
        let data: TripRequest
    }
    struct ViewModel
    {
    }
  }

