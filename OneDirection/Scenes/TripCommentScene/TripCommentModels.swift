//
//  TripCommentModels.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 4/4/19.
//  Copyright (c) 2019 Ashish  Nautiyal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum TripComment
{
    // MARK: Use cases
    
    struct Request
    {
    }
    struct Response : Codable
    {
        let success: Bool
        let data: [Comment]
    }
    struct AddCommentResponse : Codable
    {
        let success: Bool
        let data: Comment
    }
    struct ViewModel
    {
    }
}
