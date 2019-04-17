//
//  MapRouteResponse.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 4/12/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
class MapRouteResponse : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(response, forKey: "route")
        aCoder.encode(id, forKey: "id")
    }
    
    required init(coder : NSCoder) {
      response =  coder.decodeObject(forKey: "route")
        id = coder.decodeObject(forKey: "id") as! String
    }
    
    let response: Any?
    let id: String
    
    init(response: Any?,id: String) {
        self.response = response
        self.id = id
    }
    
}
