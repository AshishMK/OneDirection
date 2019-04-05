//
//  MyDestinationListInteractor.swift
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

protocol MyDestinationListBusinessLogic
{
    func getMyTrips()
    func deleteTicketRequest(request: MyDestinationList.RequestDeleteTicket)
    func deleteTrip(request: MyDestinationList.RequestDeleteTrip)
}

protocol MyDestinationListDataStore
{
    //var name: String { get set }
}

class MyDestinationListInteractor: MyDestinationListBusinessLogic, MyDestinationListDataStore
{
    func deleteTrip(request: MyDestinationList.RequestDeleteTrip) {
        worker = MyDestinationListWorker()
        worker?.deleteTrip(body : request,completion: {(success,message)
            in
            self.presenter?.deleteTrip(success: success, message: message,posintion: request.position)
        }
        )
    }
    
    var presenter: MyDestinationListPresentationLogic?
    var worker: MyDestinationListWorker?
    
    // MARK: Do something
    func getMyTrips()
    {
        worker = MyDestinationListWorker()
        worker?.getMyTrips(completion: {(trips,error)
            in
            self.presenter?.presentList(trip: trips, error: error)
        }
        )
    }
    
    func deleteTicketRequest(request: MyDestinationList.RequestDeleteTicket) {
        worker = MyDestinationListWorker()
        worker?.deleteTicketrequest(body : request,completion: {(success,message)
            in
            self.presenter?.deleteBookingRequest(success: success, message: message,posintion: request.position)
        }
        )
    }
    
}
