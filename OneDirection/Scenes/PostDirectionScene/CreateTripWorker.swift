//
//  CreateTripWorker.swift
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

class CreateTripWorker
{
    func createTripOD(body: CreateTrip.Request,completion: @escaping (Bool, String) -> Void)
    {
        var params = [String:String] ()
        params ["uid"] = body.uid
        params ["description"] = body.description
        params ["latStart"] = body.latStart
        params ["longStart"] = body.longStart
        params ["latEnd"] = body.latEnd
        params ["longEnd"] = body.longEnd
        params ["title"] = body.title
        params ["startsDate"] = body.startsDate
        params ["endDate"] = body.endDate
        params ["pals"] = body.pals
        MainWorker.taskForPOSTRequest(url: MainWorker.Endpoints.createTripOD.url, responseType: CreateTrip.Response.self, parameters: params){ (response,error)
            in
            if let response = response {
                
                completion(response.success,response.data.id)
            }
            else {
                completion(false,error?.localizedDescription ?? "")
            }
        }
    }
}