//
//  RecentTripCommentsInteractor.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 4/5/19.
//  Copyright (c) 2019 Ashish  Nautiyal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RecentTripCommentsBusinessLogic
{
    func getCommentsByUserId()
    func getTripById(trip_id: String)
}

protocol RecentTripCommentsDataStore
{
    //var name: String { get set }
}

class RecentTripCommentsInteractor: RecentTripCommentsBusinessLogic, RecentTripCommentsDataStore
{
    var presenter: RecentTripCommentsPresentationLogic?
    var worker: RecentTripCommentsWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func getCommentsByUserId()
    {
        worker = RecentTripCommentsWorker()
        worker?.getTripCommentsByUserId( completion: {(comments,error)
            in
            self.presenter?.presentList(comments: comments, error: error)
        })
    }
    func getTripById(trip_id: String)
    {
        worker = RecentTripCommentsWorker()
        worker?.getTripDetails(trip_id: trip_id, completion: {(trip,error)
            in
            self.presenter?.handleTripData(trip: trip, error: error)
        })
    }
}
