//
//  EventsViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/27/23.
//

import Foundation
import UIKit
import SwiftUI

class EventsViewController: UIViewController {
    
    @State var userAuth = UserAuthentication()
    //@State var currentUser = userAuth.currUser
    
    // TODO JOSH
    // BUTTON - CREATE EVENT
    
    // TODO - in original Text(MY EVENTS) - line 55 in EventsView
    // I do .onAppear for allEvents - do this here
    
    private var myEventsText: UITextView = {
        let text = UITextView()
        
        let attributedString = NSMutableAttributedString.init(string: "MY EVENTS")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor(white: 1, alpha: 1), range: NSRange.init(location: 0, length: attributedString.length))
        text.attributedText = attributedString
        
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 40, weight: .bold)
        text.toggleUnderline(true)
        return text
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Add subviews
        view.addSubview(myEventsText)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        view.frame = view.bounds
        
        myEventsText.frame = CGRect(x: (view.width - size) / 2,
                                    y: 50,
                                    width: size,
                                    height: size)
        
    }
}

#Preview {
    EventsViewController()
}
