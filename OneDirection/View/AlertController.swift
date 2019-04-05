//
//  AlertController.swift
//  OneDirection
//
//  Created by Ashish Nautiyal on 3/12/19.
//  Copyright © 2019 Ashish  Nautiyal. All rights reserved.
//

import Foundation
import UIKit
class AlertController {
    class func showAlert(_ title: String,message: String, actionLabel : String = "OK", actionLabel2 : String = "Cancel", completion: ((UIAlertAction)-> Void)? = nil, completion2: ((UIAlertAction)-> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: actionLabel, style: .default, handler: completion))
        if let _ = completion2 {
        alertVC.addAction(UIAlertAction(title: actionLabel2, style: .default, handler: completion2))
        }
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
        if let topController = UIApplication.topViewController() {
            topController.present(alertVC,animated: true, completion: nil)
        }
    }
    
    
}
