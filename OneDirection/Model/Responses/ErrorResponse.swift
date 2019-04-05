//
//  ErrorResponse.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/8/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
struct ErrorResponse : Codable{
    let success: Bool
    let message: String
    enum CodingKeys: String, CodingKey {
        case success
        case message = "data"
    }
}
extension ErrorResponse: LocalizedError {
    var errorDescription : String? {
        return message
    }
    
}
