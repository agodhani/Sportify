//
//  EventsViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/27/23.
//

import Foundation
import UIKit
import SwiftUI

struct EventsViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = EventsViewController
    @ObservedObject var allEvents = AllEvents()
    func makeUIViewController(context: Context) -> EventsViewController {
        allEvents.getEvents()
        let vc = EventsViewController()
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: EventsViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @State var userAuth = UserAuthentication()
    @State var eventsm = EventMethods()
    
    
    //@State var currentUser = User(id: "error ID", name: "error name", email: "error email", radius: 1, zipCode: "", sportsPreferences: [0], privateAccount: true, profilePicture: "1", age: 1, birthday: Date(), friendList: [], blockList: [], eventsAttending: ["005861C7-AB71-48EF-B17A-515E88AA0D4B"], eventsHosting: [], suggestions: [])
    
        
    class CustomTableViewCell: UITableViewCell { // TODO later
        // TODO
        @IBOutlet weak var eventName: UILabel!
        @IBOutlet weak var sport: UILabel!
    }
    
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
        text.isEditable = false
        return text
    }()
    
    private var eventsText: UITextView = { // TODO don't forget to add capacity
        let text = UITextView()
        text.text = "Event"
        text.textColor = .white
        text.backgroundColor = .sportGold
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .heavy)
        text.isEditable = false
        return text
    }()
    
    private var sportText: UITextView = {
        let text = UITextView()
        text.text = ""
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .heavy)
        text.isEditable = false
        return text
    }()
    
    private var locationText: UITextView = {
        let text = UITextView()
        text.text = ""
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .heavy)
        text.isEditable = false
        return text
    }()
    
    private var dateText: UITextView = {
        let text = UITextView()
        text.text = ""
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .heavy)
        text.isEditable = false
        return text
    }()
    
    private var createEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Event", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var allEvents = [String]() // IDs
    var allEventsAsEvents = [Event]() // Events
    var allEv = AllEvents()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        allEv.getEvents()
        Task {
            await userAuth.getCurrUser()
            let currentUser = userAuth.currUser // REAL uncomment
            allEvents = currentUser?.getAllEvents() ?? [String]()
            
            for eventID in allEvents {
                await allEventsAsEvents.append(eventsm.getEvent(eventID: eventID))
            }
            self.tableView.reloadData()
        }

        // Add subviews
        view.addSubview(createEventButton)
        view.addSubview(myEventsText)
        view.addSubview(eventsText)
        view.addSubview(sportText)
        view.addSubview(locationText)
        view.addSubview(dateText)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        view.frame = view.bounds
        tableView.reloadData()

        
        createEventButton.addTarget(self, action: #selector(tappedCreateEvent), for: .touchUpInside)
        createEventButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown) // When clicked or touched down
        createEventButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside) // When clicked or touched up inside
        createEventButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside) // When clicked or touched up outside'
        
        createEventButton.frame = CGRect(x: 250,
                                        y: 40,
                                        width: 125,
                                        height: 40)
        
        myEventsText.frame = CGRect(x: (view.width - size) / 2,
                                    y: 80, // was 50
                                    width: size,
                                    height: size)
        
        eventsText.frame = CGRect(x: -450,
                                  y: 150,
                                  width: 1000,
                                  height: 50)
        
        sportText.frame = CGRect(x: -25,
                                y: 150,
                                width: size,
                                height: 50)
        
        locationText.frame = CGRect(x: 85,
                                y: 150,
                                width: size,
                                height: 50)
        
        dateText.frame = CGRect(x: 190,
                                y: 150,
                                width: size,
                                height: 50)
        
        tableView.frame = CGRect(x: 0,
                                 y: 200, // was 50
                                 width: view.width,
                                 height: view.height)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allEv.filteredEvents = allEv.events.filter({event in event.attendeeList.contains(userAuth.currUser?.id ?? "")})
        return allEv.filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        allEv.filteredEvents = allEv.events.filter({event in event.attendeeList.contains(userAuth.currUser?.id ?? "")})
        cell.textLabel?.text = allEv.filteredEvents[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // TODO SingleEventViewController
        
        let selectedEvent = allEv.filteredEvents[indexPath.row]
        let vc = SingleEventViewController() // SingleEventVC for the index
        vc.userAuth = self.userAuth
        vc.event = selectedEvent
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    @objc private func tappedCreateEvent() {
        let vc = CreateEventViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func buttonTouchDown() {
        createEventButton.backgroundColor = .darkGray
    }

    @objc private func buttonTouchUp() {
        createEventButton.backgroundColor = .sportGold
    }
}

#Preview {
    EventsViewController()
}
