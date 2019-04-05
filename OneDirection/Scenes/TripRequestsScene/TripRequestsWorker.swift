//
//  TripRequestsWorker.swift
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

class TripRequestsWorker
{
    func getTripRequests(trip_id : String,completion: @escaping ([TripRequest], Error?) -> Void)
    {
        MainWorker.taskForGETRequest(url: MainWorker.Endpoints.getTripRequestTripOD(trip_id).url, responseType: TripBookingRequests.Response.self){ (response,error)
            in
            if let response = response {
                completion(response.data.filter(){ $0.status != 3 }.filter(){ $0.creater_id != $0.uid },nil)
            }
            else {
                completion([],error)
            }
        }
    }
    
    func sendTicketrequest(body: TripRequests.Something.Request,completion: @escaping (Bool, String) -> Void)
    {
        var params = [String:String] ()
        params ["uid"] = body.uid
        params ["trip_id"] = body.trip_id
        params ["status"] = body.status
        params ["creater_id"] = body.creater_id
        MainWorker.taskForPOSTRequest(url: MainWorker.Endpoints.bookTicket.url, responseType: DestinationList.ResponseTicketBooking.self, parameters: params){ (response,error)
            in
            if let response = response {
                
                completion( response.success, String(response.uid))
            }
            else {
                completion(false,error?.localizedDescription ?? "")
            }
        }
    }
}
