//
//  Alert.swift
//  WeatherToday
//
//  Created by reena on 05/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    static func presentAlert(title: String, message:String)-> UIAlertController{
        
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        return alertController
        
        }

    
}
