//
//  SingleNotificationViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 11/15/23.
//



/*
 
 PROBABLY DON'T USE THIS
 
 Instead, make it so that if you click an event in the NotifcationVC
 it navigates you to the corresponding event ID
 
 */

import Foundation
import UIKit

class SingleNotificationViewController: UIViewController {
    
    var userAuth : UserAuthentication?
    var notification: Notification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        
    }
    
}

#Preview {
    SingleNotificationViewController()
}
