//
//  MyDestinationListViewController.swift
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
import MapKit
import CoreLocation
protocol MyDestinationListDisplayLogic: class
{
    func displayMyTrips(trip: [Trip], error: Error?)
    func deleteBookingRequest(success: Bool, message: String, posintion: Int)
    func deleteTrip(success: Bool, message: String, posintion: Int)
}

class MyDestinationListViewController: UIViewController, MyDestinationListDisplayLogic
{
    //MARK: outlets
    @IBOutlet weak var noItemView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationIten: UINavigationItem!
    
    //MARK: Variables
    var selectedTrip:Trip?
    var spinner: UIActivityIndicatorView?
    let formatter: DateFormatter = DateFormatter()
    let formatterLong: DateFormatter = DateFormatter()
    var interactor: MyDestinationListBusinessLogic?
    var router: (NSObjectProtocol & MyDestinationListRoutingLogic & MyDestinationListDataPassing)?
    
    // MARK: Lifecycle method
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        spinner = SpinnerView.showLoader(view: view)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        noItemView.isUserInteractionEnabled = true
        noItemView.addGestureRecognizer(tapGestureRecognizer)
        noItemView.addGestureRecognizer(tapGestureRecognizer)
        self.navigationIten.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showfindRouteController))
        self.navigationIten.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationIten.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
        self.navigationIten.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationIten.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner?.startAnimating()
        noItemView.isHidden = true
        interactor?.getMyTrips()
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
            vc.trip = selectedTrip
            let tripCommentViewController = destinationVC.viewControllers![2] as! TripCommentViewController
            tripCommentViewController.trip = selectedTrip
            tripRequestsViewController.tripSelected = selectedTrip
        }}
    
    // MARK: Setup
    private func setup()
    {
        formatter.dateFormat = "HH:mm a, dd MMM"
        formatterLong.dateFormat = "dd MMM'' yyyy"
        let viewController = self
        let interactor = MyDestinationListInteractor()
        let presenter = MyDestinationListPresenter()
        let router = MyDestinationListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: Navigation callback
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
    
    //MARK: IBAction
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        noItemView.isHidden = true
        spinner?.startAnimating()
        interactor?.getMyTrips()
    }
    
    // MARK: Delegate method -> MyDestinationListDisplayLogic
    func displayMyTrips(trip: [Trip], error: Error?)
    {
        
        if trip.count == 0
        {     noItemView.isHidden = false
        }
        TripModel.myTripList = trip
        spinner?.stopAnimating()
        tableView.reloadData()
        loadRoutes()
    }
    func deleteTrip(success: Bool, message: String, posintion: Int){
        if success {
            TripModel.myTripList.remove(at: posintion)
            tableView.reloadData()
            noItemView.isHidden = true
            interactor?.getMyTrips()
        }
        else{ spinner?.stopAnimating()
            AlertController.showAlert("Can not delete Trip", message: message)
            
            if  TripModel.myTripList.count == 0
            {     noItemView.isHidden = false
            }
        }
    }
    
    
    func deleteBookingRequest(success: Bool, message: String, posintion: Int){
        spinner?.stopAnimating()
        if success {
            TripModel.myTripList.remove(at: posintion)
            tableView.reloadData()
        }else {
            AlertController.showAlert("Error", message: message)
        }
    }
}

//MARK: TableView Delegates
extension MyDestinationListViewController : UITableViewDataSource, UITableViewDelegate{
    func loadRoutes(){
        for trip in TripModel.tripList {
            if  let _ = TripModel.mapRoute[trip.id]
            {
                self.tableView.reloadData()
                continue
            }
            let request = MKDirectionsRequest()
            let coordinate = CLLocationCoordinate2D(latitude: trip.latstart,longitude : trip.longstart)
            let coordinateEnd = CLLocationCoordinate2D(latitude: trip.latend,longitude : trip.longend)
            let mkPlacemark = MKPlacemark(coordinate: coordinate)
            let mkPlacemark2 = MKPlacemark(coordinate: coordinateEnd)
            request.source = MKMapItem(placemark: mkPlacemark)
            request.destination = MKMapItem(placemark: mkPlacemark2)
            request.requestsAlternateRoutes = false
            let directions = MKDirections(request: request)
            directions.calculate(completionHandler: {(response, error) in
                if error != nil {
                } else {
                    TripModel.mapRoute[trip.id] = response
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func showRoute(_ response: MKDirectionsResponse, _ mapView: MKMapView) {
        for route in response.routes {
            mapView.add(route.polyline,
                        level: MKOverlayLevel.aboveRoads)
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TripModel.myTripList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTripTableViewCell") as! MyTripTableCell
        
        let trip = TripModel.myTripList[indexPath.row]
        cell.dateLable?.text = "\(formatter.string(from: Date(milliseconds: Int(trip.startsdate)))) to \(formatterLong.string(from: Date(milliseconds: Int(trip.enddate))))"
        cell.titleLabel?.text = trip.title
        cell.userName?.text = trip.name
        let availableSeats = trip.pals  - Int(trip.count_accept ?? "0")!
        cell.seatLabel?.text = "\(availableSeats == 0 ? "No" : String(availableSeats) ) seats available"
        
        cell.descriptionLabel?.text = trip.description
        cell.initialLabel?.text = trip.name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }.uppercased()
        cell.ticketButton.addTarget(self, action: #selector(self.ticketButtonTapped(sender:)), for: .touchUpInside);
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showOwnerInfo(tapGestureRecognizer:)))
        cell.userInfoStackView.isUserInteractionEnabled = true
        cell.userInfoStackView.addGestureRecognizer(tapGestureRecognizer)
        if nil ==  trip.count {
            cell.countTextLabel.text = "No one request for booking yet"
        }
        else {
            cell.countTextLabel.text = "\(trip.count ?? "No") \(trip.count! == "1" ? "person" : "people") request for booking"
        }
        if  let directionsResponse = TripModel.mapRoute[trip.id]
        {
            showRoute(directionsResponse, cell.mapView)
            cell.mapView?.setRegion( MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trip.latstart, longitude: trip.longstart), span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta: 4)), animated: true)
        }
        if trip.uid == Int(UserManager.shared.getUserId()!) && trip.status! != 2 {
            cell.ticketButton.setImage(UIImage(named: "deleted.png"), for: UIControlState.normal)
        }
        else if nil ==  trip.status {
            cell.ticketButton.setImage(UIImage(named: "book_seat.png"), for: .normal)
        }
        else if trip.status! == 0 {
            cell.ticketButton.setImage(UIImage(named: "waiting.png"), for: .normal)
        }
        else if trip.status! == 1 {
            cell.ticketButton.setImage(UIImage(named: "accepted.png"), for: .normal)
        }
        else if trip.status! == 2 {
            cell.ticketButton.setImage(UIImage(named: "info.png"), for: .normal)
        }
        else if trip.status! == 3 {
            cell.ticketButton.setImage(UIImage(named: "cancelled.png"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTrip = TripModel.myTripList[indexPath.row]
        self.performSegue(withIdentifier: "GotoDetailSegue", sender: nil)
    }
    
    @objc func ticketButtonTapped(sender : UIButton){
        guard let cell = sender.superview?.superview?.superview?.superview?.superview?.superview as? MyTripTableCell else {
            return // or fatalError() or whatever
        }
        
        if let indexPath = tableView.indexPath(for: cell) {
            let trip: Trip = TripModel.myTripList[indexPath.row]
            if trip.uid == Int(UserManager.shared.getUserId()!) && trip.status! != 2 {
                AlertController.showAlert("Delete Trip?", message: "Really want to delete this trip?",actionLabel: "Delete",completion: {(UIAlertAction)
                    in
                    self.spinner?.startAnimating()
                    let request = MyDestinationList.RequestDeleteTrip(trip_id: trip.id, position: indexPath.row)
                    self.interactor?.deleteTrip(request: request)
                })
                
            }
            else   if let _ = trip.status {
                let messsage = trip.status! == 0 ? "Your booking request is pending \n Want to delete it?" : (trip.status! == 1 ? "Your booking request is accepted \n Want to delete it?" : (trip.status! == 3 ? "Your booking request has declined \n Want to delete it?" : "This trip has been deleted by Owner \n Want to Delete it?"))
                AlertController.showAlert("Cancel booking request?", message: messsage,actionLabel: "Delete",completion: {(UIAlertAction)
                    in
                    
                    self.spinner?.startAnimating()
                    let request = MyDestinationList.RequestDeleteTicket(uid: UserManager.shared.getUserId()!, trip_id: trip.id , position: indexPath.row)
                    self.interactor?.deleteTicketRequest(request: request) })
            }
            
        }
    }
    @objc func showOwnerInfo(tapGestureRecognizer : UITapGestureRecognizer){
        guard let cell = tapGestureRecognizer.view?.superview?.superview?.superview?.superview?.superview?.superview as? MyTripTableCell else {
            return // or fatalError() or whatever
        }
        
        if let indexPath = tableView.indexPath(for: cell) {
            let trip: Trip = TripModel.myTripList[indexPath.row]
            AlertController.showAlert(trip.title, message: "Owner -: \(trip.name)\nContact-: \(trip.phone)")
        }
    }
}
