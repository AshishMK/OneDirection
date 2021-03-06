//
//  DetailTripViewController.swift
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
import CoreData
protocol DetailTripDisplayLogic: class
{
    func updateBookingStatus(success: Bool, message: String)
    func deleteBookingRequest(success: Bool, message: String)
    func deleteTrip(success: Bool, message: String)
}

class DetailTripViewController: UIViewController, DetailTripDisplayLogic
{
    //MARK: outlets
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ticketButton: UIButton!
    @IBOutlet weak var routeText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var seatCountLabel: UILabel!
    @IBOutlet weak var countRequestLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var userInfoStackView: UIStackView!
    
    @IBOutlet weak var navigationIten: UINavigationItem!
    // MARK: Variables
    var dataController : DataController!
    var appDelegate: AppDelegate!
    var interactor: DetailTripBusinessLogic?
    var router: (NSObjectProtocol & DetailTripRoutingLogic & DetailTripDataPassing)?
    var trip: NSTripObject?
    var   spinner: UIActivityIndicatorView?
    
    // MARK: Lifecycle methods
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
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        setDetails()
        loadRoutes()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showOwnerInfo(tapGestureRecognizer:)))
        userInfoStackView.isUserInteractionEnabled = true
        userInfoStackView.addGestureRecognizer(tapGestureRecognizer)
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
    }
    
    
    // MARK: Setup
    private func setup()
    {
        let viewController = self
        let interactor = DetailTripInteractor()
        let presenter = DetailTripPresenter()
        let router = DetailTripRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    //MARK: IBActions
    @objc func showOwnerInfo(tapGestureRecognizer : UITapGestureRecognizer){
        AlertController.showAlert((self.trip?.title)!, message: "Owner -: \(trip?.name)\nContact-: \(trip?.phone)")
    }
    
    //MARK: Private methods
    func setDetails()
    {
        navigationIten.title = trip?.title
        initialLabel.layer.backgroundColor  = TripModel.colorList[ Int(arc4random_uniform(UInt32(TripModel.colorList.count)))]
        initialLabel.layer.cornerRadius = 25
        initialLabel?.text = trip!.name!.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }.uppercased()
        nameLabel?.text = trip!.name
        dateLabel?.text =  "\(appDelegate.formatter.string(from: Date(milliseconds: Int(trip!.startsdate)))) to \(appDelegate.formatterLong.string(from: Date(milliseconds: Int(trip!.enddate))))"
        descriptionTextView.text = trip?.trip_description
        let availableSeats = Int(trip!.pals)  - Int(trip?.count_accept ?? "0")!
        seatCountLabel.text = "\(availableSeats == 0 ? "No" : String(availableSeats) ) seats available"
        if nil ==  trip!.count {
            countRequestLabel.text = "No one request for booking yet"
        }
        else {
            countRequestLabel.text = "\(trip!.count ?? "No") \(trip!.count! == "1" ? "person" : "people") request for booking"
        }
        setTicketStatus()
    }
    func setTicketStatus(){
        if Int(trip!.uid) == Int(UserManager.shared.getUserId()!) {
            ticketButton.setImage(UIImage(named: "deleted.png"), for: .normal)
        }
        else if -1 ==  trip?.status {
            ticketButton.setImage(UIImage(named: "book_seat.png"), for: .normal)
        }
        else if trip?.status == 0 {
            ticketButton.setImage(UIImage(named: "waiting.png"), for: .normal)
        }
        else if trip?.status == 1 {
            ticketButton.setImage(UIImage(named: "accepted.png"), for: .normal)
        }
        else if trip?.status == 2 {
            ticketButton.setImage(UIImage(named: "info.png"), for: .normal)
        }
        else if trip?.status == 3 {
            ticketButton.setImage(UIImage(named: "cancelled.png"), for: .normal)
        }
    }
    
    //MARK: IBActions
    @IBAction func onBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onTicketButtonClicked(_ sender: Any) {
        if Int(trip!.uid) == Int(UserManager.shared.getUserId()!) {
            AlertController.showAlert("Delete Trip?", message: "Really want to delete this trip?",actionLabel: "Delete",completion: {(UIAlertAction)
                in
                self.spinner?.startAnimating()
                let request = DetailTrip.RequestDeleteTrip(trip_id: (self.trip?.id)!)
                self.interactor?.deleteTrip(request: request)
            })
        }
        else   if -1 == trip?.status {
            AlertController.showAlert("Book seat?", message: "Please send booking request for this trip?\n You will be on waiting untill owner accept your request even seats are full",actionLabel: "Book",completion: {(UIAlertAction)
                in
                self.spinner?.startAnimating()
                let request = DetailTrip.RequestTicket(uid: UserManager.shared.getUserId()!, trip_id: (self.trip?.id)!, creater_id: "\(self.trip?.uid ?? 0)", status: ("\(self.trip?.status ?? 0)"))
                self.interactor?.updateTicket(request: request)
            })
        }
        else {
            let messsage = trip?.status == 0 ? "Your booking request is pending \n Want to delete it?" : (trip?.status == 1 ? "Your booking request has accepted \n Want to delete it?" : (trip?.status == 2 ? "Trip has been deleted by owner. \n Want to delete it?" : "Your booking request has been declined. \n Want to delete it?"))
            AlertController.showAlert("Delete booking request?", message: messsage,actionLabel: "Delete",completion: {(UIAlertAction)
                in
                self.spinner?.startAnimating()
                let request = DetailTrip.RequestDeleteTicket(uid: UserManager.shared.getUserId()!, trip_id: (self.trip?.id)! )
                self.interactor?.deleteTicketRequest(request: request) })
        }
    }
    
    // MARK: Delegate method -> DetailTripDisplayLogic
    func updateBookingStatus(success: Bool, message: String) {
        spinner?.stopAnimating()
        if success {
            trip?.status = Int32(message)!
              try! dataController.viewContext.save()
            setTicketStatus()
        }
        else {
            AlertController.showAlert("Error", message: message)
        }
        
    }
    func deleteTrip(success: Bool, message: String){
        spinner?.stopAnimating()
        if success {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        else{
            AlertController.showAlert("Can not delete Trip", message: message)
        }
    }
    
    func deleteBookingRequest(success: Bool, message: String){
        spinner?.stopAnimating()
        if success {
            
            trip?.status = -1
              try! dataController.viewContext.save()
            if let deleted = trip?.is_deleted {
                if deleted {
                    self.dismiss(animated: true, completion: nil)
                    return
                }
            }
            setTicketStatus()
            
        }else {
            AlertController.showAlert("Error", message: message)
        }
    }
    
}

//MARK: MapView Delegates
extension DetailTripViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor
        overlay: MKOverlay) -> MKOverlayRenderer {
        print("gett route fot renderer")
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 1.0
        return renderer
    }
    
    func loadRoutes(){
        if  let directionsResponse = TripModel.mapRoute[trip!.id!]
        {
            showRoute(directionsResponse)
            return
        }
        let request = MKDirectionsRequest()
        let coordinate = CLLocationCoordinate2D(latitude: trip!.latstart,longitude : trip!.longstart)
        let coordinateEnd = CLLocationCoordinate2D(latitude: trip!.latend,longitude : trip!.longend)
        let mkPlacemark = MKPlacemark(coordinate: coordinate)
        let mkPlacemark2 = MKPlacemark(coordinate: coordinateEnd)
        
        request.source = MKMapItem(placemark: mkPlacemark)
        request.destination = MKMapItem(placemark: mkPlacemark2)
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {(response, error) in
            
            if error != nil {
            } else {
                TripModel.mapRoute[self.trip!.id!] = response
                self.showRoute(response!)
            }
        })
        
    }
    
    func showRoute(_ response: MKDirectionsResponse) {
        var routeString = ""
        for route in response.routes {
            mapView.add(route.polyline,
                        level: MKOverlayLevel.aboveRoads)
            for step in route.steps {
                if step.instructions == "" {
                    continue
                }
                routeString.append("\u{2022} \(step.instructions)")
                routeString.append("\n")
            }
            
        }
        routeText.text = routeString
        mapView.setRegion( MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trip!.latstart, longitude: trip!.longstart), span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta: 4)), animated: true)
    }
}
