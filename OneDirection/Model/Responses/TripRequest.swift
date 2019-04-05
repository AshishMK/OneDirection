//
//  TripRequest.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/20/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
struct TripRequest : Equatable, Codable{
    let uid : Int
    let id: String
    let trip_id: Int
    var status : Int
    let name : String
    let phone : String
    let startsdate : Double
    let enddate: Double
    var title : String
    var creater_id : Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decodeIfPresent(Int.self, forKey: .uid) ?? 0
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
          self.trip_id = try container.decodeIfPresent(Int.self, forKey: .trip_id) ?? 0
        self.creater_id = try container.decodeIfPresent(Int.self, forKey: .creater_id) ?? 0
        self.status = try container.decodeIfPresent(Int.self, forKey: .status) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        self.startsdate = try container.decodeIfPresent(Double.self, forKey: .startsdate) ?? 0
        self.enddate = try container.decodeIfPresent(Double.self, forKey: .enddate) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
   }
}
