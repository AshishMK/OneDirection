//
//  CreateTripViewController.swift
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
import CoreLocation
import MapKit
protocol CreateTripDisplayLogic: class
{
    func displaySomething(sucess: Bool, data: String)
}

class CreateTripViewController: UIViewController, CreateTripDisplayLogic
{
    //MARK: outlets
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var numberOfSeats: UITextField!
    @IBOutlet weak var startDateText: UITextField!
    @IBOutlet weak var endDateText: UITextField!
    
    // MARK: Variables
    var interactor: CreateTripBusinessLogic?
    var router: (NSObjectProtocol & CreateTripRoutingLogic & CreateTripDataPassing)?
    var startingPoint: CLPlacemark?
    var endPoint: CLPlacemark?
    var startDate: Date = Date()
    var endDate: Date = Date()
    var response: MKDirectionsResponse?
    var spinner: UIActivityIndicatorView?
    let formatter: DateFormatter = DateFormatter()
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postTrip))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        descriptionTextView.delegate = self
        startDateText.delegate =  self
        endDateText.delegate = self
        startDateText.addTarget(self, action: #selector(textFieldTapped), for: UIControlEvents.touchDown)
        endDateText.addTarget(self, action: #selector(textFieldTapped), for: UIControlEvents.touchDown)
        numberOfSeats.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startDatePicker.setMinimumDate(1)
        endDatePicker.setMinimumDate(2)
        startDateText.text = formatter.string(from:startDatePicker.date)
        endDateText.text = formatter.string(from: endDatePicker.date)
        navigationController?.setToolbarHidden(true, animated: true)
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
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let viewController = self
        let interactor = CreateTripInteractor()
        let presenter = CreateTripPresenter()
        let router = CreateTripRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: IBAction
    @objc func textFieldTapped(textField: UITextField) {
        self.view.endEditing(true)
        if textField == startDateText {
            startDatePicker.datePickerMode = UIDatePickerMode.dateAndTime
            textField.inputView = startDatePicker
            startDatePicker.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
        else {
            endDatePicker.datePickerMode = UIDatePickerMode.dateAndTime
            textField.inputView = endDatePicker
            endDatePicker.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let selectedDate = formatter.string(from: sender.date)
        
        if  startDateText.isFirstResponder{
            startDate = sender.date
            endDatePicker.setMinimumDate(1,date: sender.date)
            startDateText.text = selectedDate
        }
        else{
            endDate = sender.date
            endDateText.text = selectedDate
        }
    }
    
    
    @objc func postTrip(){
        
        if startDateText.text?.count == 0  {
            AlertController.showAlert("Request Failed",message: "Please enter date of starting the trip" )
            return
        }
        if endDateText.text?.count == 0 {
            AlertController.showAlert("Request Failed",message: "Please enter date of end of trip" )
            return
        }
        if numberOfSeats.text?.count == 0 ||  numberOfSeats.text == "0" {
            AlertController.showAlert("Request Failed",message: "Please enter valid number of available seats " )
            return
        }
        if descriptionTextView.text?.count == 0 ||  descriptionTextView.textColor == UIColor.lightGray {
            AlertController.showAlert("Request Failed",message: "Please write description about the trip" )
            return
        }
        print("\(descriptionTextView.text) gg \(numberOfSeats.text)")
        
        guard let _ = startingPoint else {
            AlertController.showAlert("Request Failed",message: "Please enter starting point" )
            return
        }
        guard let _ = endPoint else {
            AlertController.showAlert("Request Failed",message: "Please enter destination point" )
            return
        }
        let request = CreateTrip.Request(uid: UserManager.shared.getUserId()!, title: "\((startingPoint?.locality == nil ? startingPoint?.name : startingPoint?.locality) ?? "") to \( (endPoint?.locality == nil ? endPoint?.name : endPoint?.locality) ?? "")", description: descriptionTextView.text, latStart: "\(startingPoint?.location?.coordinate.latitude ?? 0)", longStart:"\(startingPoint?.location?.coordinate.longitude ?? 0)", latEnd: "\(endPoint?.location?.coordinate.latitude ?? 0)", longEnd: "\(endPoint?.location?.coordinate.longitude ?? 0)", pals: numberOfSeats.text ?? "1", startsDate: "\(startDatePicker.date.millisecondsSince1970)", endDate: "\(endDatePicker.date.millisecondsSince1970)")
        spinner?.startAnimating()
        interactor?.createTripOD(request: request)
    }
    
    
    // MARK: Delegate method -> CreateTripDisplayLogic
    func displaySomething(sucess: Bool, data: String)
    {spinner?.stopAnimating()
        if !sucess{
            AlertController.showAlert("Unable to create Trip", message: data)
        }
        else{
            (navigationController?.topViewController?.dismiss(animated: true, completion: nil))
        }
    }
}

//MARK: UITextViewDelegate Delegates
extension CreateTripViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = ""
            descriptionTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text == "" {
            descriptionTextView.text = "Add description/itinerary"
            descriptionTextView.textColor = UIColor.lightGray
        }
    }
}

extension CreateTripViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //        if textField == startDateText || textField == endDateText{
        //            return false; //do not show keyboard nor cursor
        //        }
        return true
    }}

//MARK: Date Delegates
extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

//MARK: UIDatePicker Delegates
extension UIDatePicker {
    func setMinimumDate(_ hour : Int, date : Date = Date()) {
        let currentDate = date
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.hour = hour
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        self.minimumDate = minDate
    }
}
