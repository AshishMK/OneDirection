//
//  Trip.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/17/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
struct Trip : Equatable, Codable{
    let uid : Int
    let id: String
    let title: String
    let description : String
    let latstart : Double
    let longstart : Double
    let latend : Double
    let longend : Double
    let pals : Int
    let startsdate : Double
    let enddate: Double
    let name: String
    let phone: String
    var status : Int?
    var count : String?
    var count_accept : String?
    var deleted: Bool
}
