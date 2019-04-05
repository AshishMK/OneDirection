//
//  TripCommentPresenter.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 4/4/19.
//  Copyright (c) 2019 Ashish  Nautiyal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TripCommentPresentationLogic
{
    func presentList(comments: [Comment], error: Error?)
    func addComment(comment: Comment?, error: Error?)
    func deleteComment(comment: Comment?, error: Error?,position: Int)
}

class TripCommentPresenter: TripCommentPresentationLogic
{
    weak var viewController: TripCommentDisplayLogic?
    
    // MARK: Do something
    
    func presentList(comments: [Comment], error: Error?)
    {
        viewController?.showComments(comments: comments, error: error)
    }
    func addComment(comment: Comment?, error: Error?){
        viewController?.commentAdded(comment: comment, error: error)
    }
    func deleteComment(comment: Comment?, error: Error?,position: Int){
   viewController?.commentDeleted(comment: comment, error: error, posintion: position)
    }
}
