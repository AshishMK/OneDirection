//
//  DetailTripInteractor.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/20/19.
//  Copyright (c) 2019 Ashish  Nautiyal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailTripBusinessLogic
{
    
    func updateTicket(request: DetailTrip.RequestTicket)
    func deleteTicketRequest(request: DetailTrip.RequestDeleteTicket)
    func deleteTrip(request: DetailTrip.RequestDeleteTrip)
}

protocol DetailTripDataStore
{
    //var name: String { get set }
}

class DetailTripInteractor: DetailTripBusinessLogic, DetailTripDataStore
{
    var presenter: DetailTripPresentationLogic?
    var worker: DetailTripWorker?
    
    
    
    func updateTicket(request: DetailTrip.RequestTicket) {
        worker = DetailTripWorker()
        worker?.sendTicketrequest(body : request,completion: {(success,message)
            in
            self.presenter?.updateBookingstatus(success: success, message: message)
        }
        )
    }
    
    func deleteTicketRequest(request: DetailTrip.RequestDeleteTicket) {
        worker = DetailTripWorker()
        worker?.deleteTicketrequest(body : request,completion: {(success,message)
            in
            self.presenter?.deleteBookingRequest(success: success, message: message)
        }
        )
    }
    func deleteTrip(request: DetailTrip.RequestDeleteTrip) {
        worker = DetailTripWorker()
        worker?.deleteTrip(body : request,completion: {(success,message)
            in
            self.presenter?.deleteTrip(success: success, message: message)
        }
        )
    }
}
