//
//  RecentTripCommentsViewController.swift
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

protocol RecentTripCommentsDisplayLogic: class
{
    func showComments(comments : [Comment], error: Error?)
     func handleTripData(trip: Trip?, error: Error?)
}
class RecentTripCommentsViewController: UIViewController, RecentTripCommentsDisplayLogic
{
    @IBOutlet weak var noItemView: UIView!
    
    @IBOutlet weak var navigationIten: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    var appDelegate: AppDelegate!
    var   spinner: UIActivityIndicatorView?
    var interactor: RecentTripCommentsBusinessLogic?
    var selectedTrip:Trip?
    var router: (NSObjectProtocol & RecentTripCommentsRoutingLogic & RecentTripCommentsDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = RecentTripCommentsInteractor()
        let presenter = RecentTripCommentsPresenter()
        let router = RecentTripCommentsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: IBAction
    @objc func  refressTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        noItemView.isHidden = true
        spinner?.startAnimating()
        interactor?.getCommentsByUserId()
    }
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
        if(segue.identifier == "detailSegue"){
            let destinationVC = segue.destination as! UITabBarController
            let vc = destinationVC.viewControllers![0] as! DetailTripViewController
            let tripRequestsViewController = destinationVC.viewControllers![1] as! TripRequestsViewController
            let tripCommentViewController = destinationVC.viewControllers![2] as! TripCommentViewController
            vc.trip = selectedTrip
            tripCommentViewController.trip = selectedTrip
            tripRequestsViewController.tripSelected = selectedTrip
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationIten.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showfindRouteController))
        self.navigationIten.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationIten.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
        self.navigationIten.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationIten.leftBarButtonItem?.tintColor = UIColor.white
        spinner = SpinnerView.showLoader(view: view)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(refressTapped(tapGestureRecognizer:)))
        noItemView.isUserInteractionEnabled = true
        noItemView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func showfindRouteController(_ updateLocation: Bool){
        self.performSegue(withIdentifier: "findRouteSegue", sender: nil)
    }
    @objc func logOut(){
        AlertController.showAlert("Logout", message: "Sure to logout?",actionLabel: "Logout",completion: {
            (alert)
            in
            UserManager.shared.resetUserData()
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noItemView.isHidden = true
        spinner?.startAnimating()
        interactor?.getCommentsByUserId()
    }
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    func showComments(comments : [Comment], error: Error?){
        if comments.count == 0
        {     noItemView.isHidden = false
        }
        spinner?.stopAnimating()
        TripModel.tripComments = comments
        tableView.reloadData()
    }
    func handleTripData(trip: Trip?, error: Error?){
        spinner?.stopAnimating()
        if let error = error {
            AlertController.showAlert("Ooops Something went wrong", message: error.localizedDescription)
        }
        else {
            selectedTrip = trip
               self.performSegue(withIdentifier: "detailSegue", sender: nil)
        }
    }
    
}
//MARK: TableView Delegates
extension RecentTripCommentsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  TripModel.tripComments.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTabelCell
        let comment = TripModel.tripComments[indexPath.row]
        cell.nameLabel.text = comment.title
        cell.commentLabel.text = "\(comment.name): \(comment.comment)"
        cell.initialLabel?.text = comment.name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }.uppercased()
        cell.dateLabel?.text = appDelegate.formatter.string(from: Date(milliseconds: Int(comment.cmnt_time)))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        spinner?.startAnimating()
        let comment = TripModel.tripComments[indexPath.row]
    interactor?.getTripById(trip_id: String(comment.trip_id))
    }
    
}
