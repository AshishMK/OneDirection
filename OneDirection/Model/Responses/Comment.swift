//
//  Comment.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 4/4/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
struct Comment : Codable{
    let id : String
    let comment: String
    let uid : Int
    let trip_id: Int
    let name: String
    let phone: String
    let cmnt_time: Double
    let creater_id: Int
    let title: String

}
