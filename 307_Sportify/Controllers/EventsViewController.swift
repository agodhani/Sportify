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
    @State var eventsm = EventMethods()
    
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
    
    private var eventsText: UITextView = { // TODO don't forget to add capacity
        let text = UITextView()
        text.text = "Event"
        text.textColor = .white
        text.backgroundColor = .sportGold
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .heavy)
        return text
    }()
    
    private var sportText: UITextView = {
        let text = UITextView()
        text.text = "Sport"
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .heavy)
        return text
    }()
    
    private var locationText: UITextView = {
        let text = UITextView()
        text.text = "Location"
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .heavy)
        return text
    }()
    
    private var dateText: UITextView = {
        let text = UITextView()
        text.text = "Date"
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .heavy)
        return text
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        @State var currentUser = userAuth.currUser
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Add subviews
        view.addSubview(myEventsText)
        view.addSubview(eventsText)
        view.addSubview(sportText)
        view.addSubview(locationText)
        view.addSubview(dateText)
        
        view.addSubview(scrollView)
        
        
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
        eventsText.frame = CGRect(x: -450,
                                  y: 120,
                                  width: 1000,
                                  height: 50)
        sportText.frame = CGRect(x: -25,
                                y: 120,
                                width: size,
                                height: 50)
        locationText.frame = CGRect(x: 85,
                                y: 120,
                                width: size,
                                height: 50)
        dateText.frame = CGRect(x: 190,
                                y: 120,
                                width: size,
                                height: 50)
        
        
    }
}

#Preview {
    EventsViewController()
}
