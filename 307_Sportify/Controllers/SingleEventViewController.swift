//
//  SingleEventViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/28/23.
//

import UIKit
import Firebase

// TODO make this look nice

class MyCell: UITableViewCell {
    
    var buttonTapCallback: () -> () = { }
    
    
    let kickButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kick", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .red
        return lbl
    }()
    
    @objc func tappedKickButton() {
        buttonTapCallback()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Add button
        contentView.addSubview(kickButton)
        kickButton.addTarget(self, action: #selector(tappedKickButton), for: .touchUpInside)
        
        // Set constraints as per your requirements
        kickButton.translatesAutoresizingMaskIntoConstraints = false
        kickButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        kickButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        kickButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        kickButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        //Add label
        contentView.addSubview(label)
        //Set constraints as per your requirements
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: kickButton.trailingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SingleEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userAuth : UserAuthentication?
    var event: EventHighLevel?
    private var sportList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash", "Error"]
    var isPrivate = false;
    var attendeeListAsUsers = [User]()
    var requestListAsUsers = [User]()
    var allUsers = AllUsers()
    var userm = UserMethods()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 50)
        return scrollView
    }()
    
    private var picView: UIImageView = {
        let picView = UIImageView()
        //picView.image = UIImage(systemName: "trophy.circle")
        picView.layer.masksToBounds = true
        picView.contentMode = .scaleAspectFit
        picView.layer.borderWidth = 2
        picView.layer.borderColor = UIColor.lightGray.cgColor
        return picView
    }()
    
    private var eventNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 45, weight: .bold)
        text.toggleUnderline(true)
        text.isScrollEnabled = false
        return text
    }()
    
    private var descriptionText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        text.isScrollEnabled = false
        return text
    }()
    
    private var hostNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        text.isScrollEnabled = false
        return text
    }()
    
    private var locationNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        text.isScrollEnabled = false
        return text
    }()
    
    private var sportNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        text.isScrollEnabled = false
        return text
    }()
    
    private var maxParticipantsText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        text.isScrollEnabled = false
        return text
    }()
    
    private var privateEventText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        text.isScrollEnabled = false
        return text
    }()
    
    private var eventDateText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        text.isScrollEnabled = false
        return text
    }()
    
    // tag = 1
    private let attendeeTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = 1
        tableView.layer.cornerRadius = 20
        //tableView.register(MyCell.self, forCellReuseIdentifier: "MyCell") // uncomment for custom cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // tag = 2
    private let requestTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = 2
        tableView.layer.cornerRadius = 20
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let joinLeaveButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitle("Join Event", for: .normal)
        return button
    }()
    
    private let editEventButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitle("Edit Event", for: .normal)
        button.backgroundColor = .sportGold
        return button
    }()
    
    private let announcementButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitle("Send announcement", for: .normal)
        button.backgroundColor = .sportGold
        return button
    }()
    
    func updateLists() {
        Task {
            self.attendeeListAsUsers = await event?.attendeeListAsUsers() ?? [User]()
            self.requestListAsUsers = await event?.requestListAsUsers() ?? [User]()
            self.attendeeTableView.reloadData()
            self.requestTableView.reloadData()
        }
    }
    
    var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .firstBaseline
        stack.spacing = 10
        return stack
    }()
        
    func downloadPic(picView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                picView.image = image
            }
        }).resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //let userAuth = UserAuthentication()
        //self.name.text = userAuth.currUser?.name
        
        let eventID = event?.id
        
        let picPath = "eventPictures/" + (eventID ?? "") + "_event_picture.png"
        
        // get pic from db
        StorageManager.shared.downloadUrl(for: picPath, completion: { result in
            switch result {
            case.success(let url):
                self.downloadPic(picView: self.picView, url: url)
            case.failure(let error):
                print("failed to get url: \(error)")
                DispatchQueue.main.async {
                    let image = UIImage(systemName: "trophy.circle")
                    self.picView.image = image
                }
            }
        })
    }
    // Back button
    private let backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
               backButton.setTitle("Back", for: .normal)
               backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
               backButton.sizeToFit()
        return backButton
    }()
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        //        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        //backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        attendeeTableView.tag = 1
        attendeeTableView.delegate = self
        attendeeTableView.dataSource = self
        requestTableView.tag = 2
        requestTableView.delegate = self
        requestTableView.dataSource = self
        
        Task {
            var user = await userAuth?.getCurrUser()
            self.attendeeListAsUsers = await event?.attendeeListAsUsers() ?? [User]()
            self.requestListAsUsers = await event?.requestListAsUsers() ?? [User]()
            self.attendeeTableView.reloadData()
            self.requestTableView.reloadData()
        }
        
        updateLists()
        
        
        let currUserID = userAuth?.currUser?.id ?? ""
        if (event?.userIsAttending(userID: currUserID) == false) {
            // join button
            joinLeaveButton.setTitle("Join", for: .normal)
            joinLeaveButton.backgroundColor = .green
        } else {
            // leave button
            joinLeaveButton.setTitle("Leave", for: .normal)
            joinLeaveButton.backgroundColor = .red
            print("HERE")
        }
        
        
        /*vStack.addArrangedSubview(eventNameText)
        vStack.addArrangedSubview(descriptionText)
        vStack.addArrangedSubview(hostNameText)
        vStack.addArrangedSubview(locationNameText)
        view.addSubview(vStack)*/

        
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(eventNameText)
        scrollView.addSubview(picView)
        scrollView.addSubview(descriptionText)
        scrollView.addSubview(hostNameText)
        scrollView.addSubview(locationNameText)
        scrollView.addSubview(sportNameText)
        scrollView.addSubview(maxParticipantsText)
        scrollView.addSubview(privateEventText)
        scrollView.addSubview(eventDateText)
        scrollView.addSubview(attendeeTableView)
        scrollView.addSubview(requestTableView)
        scrollView.addSubview(joinLeaveButton)
        if (currUserID == event?.eventHost || (event?.adminsList.contains(currUserID) ?? false)) {
            // if the user is the host or an admin - display the button
            scrollView.addSubview(editEventButton)
            scrollView.addSubview(announcementButton)
        }
        
        eventNameText.text = (event?.name ?? "Error Event Name")
        descriptionText.text = "Event Description: " + (event?.description ?? "Error description")
        hostNameText.text = "Event Host: " + (event?.eventHostName ?? "Event Host Error")
        locationNameText.text = "Location: " + (event?.location ?? "Location Error")
        sportNameText.text = "Sport: " + sportList[event?.sport ?? 16]
        maxParticipantsText.text = "Participants: " + String(event?.attendeeList.count ?? 0) + "/" + String(event?.maxParticipants ?? 0)
        eventDateText.text = "Event Date: " + String(event?.date.formatted() ?? Date().formatted())
        
        isPrivate = event?.privateEvent ?? false
        if (isPrivate) { // private event
            privateEventText.text = "Private Event"
            privateEventText.textColor = .red
        } else {
            privateEventText.text = "Public Event"
            privateEventText.textColor = .green
        }
        
        self.attendeeTableView.reloadData()
        self.requestTableView.reloadData()


        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        scrollView.frame = view.bounds
        scrollView.backgroundColor = .black
        
        announcementButton.addTarget(self, action: #selector(tappedSendAnnouncement), for: .touchUpInside)
        joinLeaveButton.addTarget(self, action: #selector(tappedJoinLeaveButton), for: .touchUpInside)
        editEventButton.addTarget(self, action: #selector(tappedEditEventButton), for: .touchUpInside)
        
        editEventButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown) // When clicked or touched down
        editEventButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside) // When clicked or touched up inside
        editEventButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside) // When clicked or touched up outside'


        /*vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        vStack.frame = CGRect(x: 25,
                              y: 70,
                              width: size,
                              height: size)*/
        backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)
        picView.frame = CGRect(x: 120,
                               y: -50,
                               width: scrollView.width / 2.5,
                               height: scrollView.width / 2.5)
        picView.layer.cornerRadius = picView.width / 2
        eventNameText.frame = CGRect(x: 25,
                                     y: picView.bottom + 10,
                                    width: size,
                                    height: 120)
        
        descriptionText.frame = CGRect(x: 25,
                                       y: eventNameText.bottom,
                                    width: size,
                                    height: 32)
        
        hostNameText.frame = CGRect(x: 25,
                                    y: descriptionText.bottom,
                                    width: size,
                                    height: 32)
        locationNameText.frame = CGRect(x: 25,
                                        y: hostNameText.bottom,
                                    width: size,
                                    height: 32)
        sportNameText.frame = CGRect(x: 25,
                                     y: locationNameText.bottom,
                                    width: size,
                                    height: 32)
        privateEventText.frame = CGRect(x: 25,
                                        y: sportNameText.bottom,
                                    width: size,
                                    height: 32)
        eventDateText.frame = CGRect(x: 25,
                                     y: privateEventText.bottom,
                                    width: size,
                                    height: 32)
        maxParticipantsText.frame = CGRect(x: 25,
                                           y: eventDateText.bottom,
                                           width: size,
                                           height: 32)
        attendeeTableView.frame = CGRect(x: 35,
                                         y: maxParticipantsText.bottom + 20,
                                    width: size,
                                    height: 100)
        requestTableView.frame = CGRect(x: 35,
                                        y: attendeeTableView.bottom + 40,
                                    width: size,
                                    height: 100)
        joinLeaveButton.frame = CGRect(x: 30,
                                       y: 750,
                                       width: 80,
                                       height: 45)
        editEventButton.frame = CGRect(x: joinLeaveButton.right + 20,
                                       y: 750,
                                       width: 110,
                                       height: 45)
        announcementButton.frame = CGRect(x: editEventButton.right + 20,
                                          y: 750,
                                          width: 110,
                                          height: 45)
        
        
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func tappedSendAnnouncement() {
        print("tapped annpoumce,ent")
        let alertController = UIAlertController(title: "Send Announcement", message: "Enter Announcement Message", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Message"
        }
        
        let sendAction = UIAlertAction(title: "Send", style: .default) { [weak self] _ in
            
            guard let announcementMessage = alertController.textFields?.first?.text, !announcementMessage.isEmpty else {
                // Show an error message if the text field is empty
                self?.showAlert(message: "Please enter the announcement message.")
                return
            }
            
            // SEND ANNOUNCEMENT HERE
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("announcement canceled")
        }
        
        alertController.addAction(sendAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func tappedJoinLeaveButton() {
        var currUserID = userAuth?.currUser?.id ?? ""
        var currUser = userAuth?.currUser
        let notifsm = NotificationMethods()
        var notificationID = ""
        //Create Notification
        
        if (event?.userIsAttending(userID: currUserID) == false) {
            
            if (event?.privateEvent ?? false) {
                // if it's a private event - prompt them for code or request
                
                let privateAlertController = UIAlertController(title: "Join Event", message: "How would you like to join the private event?", preferredStyle: .alert)
                
                let codeOption = UIAlertAction(title: "Code", style: .default) { _ in
                    
                    let alertController = UIAlertController(title: "Join Event", message: "Enter Event Code:", preferredStyle: .alert)
                    alertController.addTextField { textField in
                        textField.placeholder = "Event Code"
                    }
                    
                    let joinAction = UIAlertAction(title: "Join", style: .default) { [weak self] _ in
                        
                        guard let eventCode = alertController.textFields?.first?.text, !eventCode.isEmpty else {
                            // Show an error message if the text field is empty
                            self?.showAlert(message: "Please enter the event code.")
                            return
                        }
                        
                        // Check if the entered event code matches the event's code
                        if eventCode == self?.event?.code {
                            // Event code is correct, join the event
                            self?.event?.joinEvent(id: currUserID)
                            let db = Firestore.firestore()
                            let id = (self?.event?.id)!
                            db.collection("Events").document(id).updateData(["attendeeList":self?.event?.attendeeList ?? []])
                            print("EVENT JOINED")
                            currUser?.joinEvent(eventID: self?.event?.id ?? "")
                            //JOIN EVENT NOTIFICATION
                            let eventName = self?.event?.name
                            let host_name = self?.event?.eventHostName
                            //Create new Join Notification
                            Task {
                                try await notificationID = notifsm.createNotification(type: .join, id: currUserID, event_name: eventName ?? "", host_name: host_name ?? "", event_id: self?.event?.id ?? "")
                                print("NOTIFICATION CREATED")
                            }
                            currUser?.notifications.insert(notificationID, at: 0)
                            print("Notification added to user array")
                            //TODO
                            
                            let joinedAlertController = UIAlertController(title: "Success", message: "You've successfully joined the event.", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            joinedAlertController.addAction(okAction)
                            self?.present(joinedAlertController, animated: true, completion: nil)
                            self?.updateLists()
                            
                        } else {
                            // Event code is incorrect, show an error message
                            self?.showAlert(message: "Incorrect event code. Please try again.")
                        }
                    }
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                        print("Join canceled")
                    }
                    
                    alertController.addAction(joinAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                    self.updateLists()
                }
                
                let requestOption = UIAlertAction(title: "Send Request", style: .default) { _ in
                    // add user to event requestList and update DB
                    self.event?.addUserToRequestList(userID: currUserID)
                    
                    // send notification to event host
                    // the notification when clicked takes the host to this SingleEventVC
                    let db = Firestore.firestore()
                    let eventName = self.event?.name
                    let host_name = self.event?.eventHostName
                    
                    Task{
                        
                        var eventHostUser = await self.userm.getUser(user_id: self.event?.eventHost ?? "")
                        
                        try await notificationID = notifsm.createNotification(type: .request, id: currUserID, event_name: eventName ?? "", host_name: host_name ?? "", event_id: self.event?.id ?? "")
                        print(notificationID)
                        print("NOTIFICATION CREATED")
                        eventHostUser.notifications.insert(notificationID, at: 0)
                        try await db.collection("Users").document(eventHostUser.id).updateData(["notifications":eventHostUser.notifications])
                    }
                    
                    
                    // SUCCESS MESSAGE
                    let requestSuccessController = UIAlertController(title: "Request Sent", message: "Request successfully sent!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    requestSuccessController.addAction(okAction)
                    self.present(requestSuccessController, animated: true, completion: nil)
                    self.updateLists()
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    print("Join canceled")
                }
                
                privateAlertController.addAction(codeOption)
                privateAlertController.addAction(requestOption)
                privateAlertController.addAction(cancelAction)
                self.present(privateAlertController, animated: true, completion: nil)
                
            } else {
                // not a private event - join the event
                self.event?.joinEvent(id: currUserID)
                let db = Firestore.firestore()
                let id = (self.event?.id)!
                db.collection("Events").document(id).updateData(["attendeeList":self.event?.attendeeList ?? []])
                print("EVENT JOINED")
                currUser?.joinEvent(eventID: self.event?.id ?? "")
                
                // JOIN EVENT NOTIFICATION
                let eventName = self.event?.name
                let host_name = self.event?.eventHostName
                // Create new Join Notification
                Task{
                    try await notificationID = notifsm.createNotification(type: .join, id: currUserID, event_name: eventName ?? "", host_name: host_name ?? "", event_id: self.event?.id ?? "")
                    print(notificationID)
                    print("NOTIFICATION CREATED")
                    currUser?.notifications.insert(notificationID, at: 0)
                    try await db.collection("Users").document(currUserID).updateData(["notifications":currUser?.notifications ?? []])
                }
                
                let joinedAlertController = UIAlertController(title: "Success", message: "You've successfully joined the event.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                joinedAlertController.addAction(okAction)
                present(joinedAlertController, animated: true, completion: nil)
                updateLists()
            }
            
            
        } else {
            // Remove User from Attendee List
            let db = Firestore.firestore()
            let id = (event?.id)!
            if let index = event?.attendeeList.firstIndex(of: currUserID) {
                event?.attendeeList.remove(at: index)
            }
            if let index2 = event?.adminsList.firstIndex(of: currUserID) {
                event?.adminsList.remove(at: index2)
                db.collection("Events").document(id).updateData(["adminsList":event?.adminsList ?? []])
                print("EVENT LEFT")
            }
            
            db.collection("Events").document(id).updateData(["attendeeList":event?.attendeeList ?? []])
            print("EVENT LEFT")
            if((event?.attendeeList.isEmpty ?? false)) {
                var eventsm = EventMethods()
                Task {
                    await eventsm.deleteEvent(eventID: event?.id ?? "")
                }
            } else if(event?.eventHost == currUserID) {
                var attendee = event?.attendeeList.first
                event?.eventHost = attendee ?? "error"
                event?.eventHostName = "New Event Host - name todo"
                db.collection("Events").document(id).updateData(["eventHostName":event?.eventHostName ?? "error"])
                db.collection("Events").document(id).updateData(["eventHostID":event?.eventHost ?? "error"])
            }
            currUser?.leaveEvent(eventID: event?.id ?? "")
            //LEAVE EVENT NOTIFICATION
            let eventName = self.event?.name
            let host_name = self.event?.eventHostName
            Task{
                try await notificationID = notifsm.createNotification(type: .leave, id: currUserID, event_name: eventName ?? "", host_name: host_name ?? "", event_id: self.event?.id ?? "")
                print(notificationID)
                print("Leave NOTIFICATION CREATED")
                currUser?.notifications.insert(notificationID, at: 0)
                try await db.collection("Users").document(currUserID).updateData(["notifications":currUser?.notifications ?? []])
            }
            
            let leaveAlertController = UIAlertController(title: "Success", message: "You've successfully left the event.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            leaveAlertController.addAction(okAction)
            present(leaveAlertController, animated: true, completion: nil)
            updateLists()
            
        }
        
    }
    
    @objc private func tappedEditEventButton() {
        let vc = EditEventViewController()
        vc.event = event
        vc.userid = userAuth?.currUser?.id
        navigationController?.pushViewController(vc, animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 1) {
            return attendeeListAsUsers.count
        } else {
            return requestListAsUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView.tag == 1) {
            //let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell // uncomment for custom cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = attendeeListAsUsers[indexPath.row].name
            /*cell.buttonTapCallback = { // uncomment for custom cell
                print("TAP CALL BACK WORKS")
            }*/
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = requestListAsUsers[indexPath.row].name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // indexPath.row = index of the array
        Task {
            var user = await userAuth?.getCurrUser()
        }
        var currUser = userAuth?.currUser
        let currUserID = userAuth?.currUser?.id ?? ""
        if (currUserID == event?.eventHost || (event?.adminsList.contains(currUserID) ?? false)) {
            
            let alertController = UIAlertController(title: "Alert", message: "Choose an action:", preferredStyle: .alert)
            
            if (tableView.tag == 1) {
                // attenedeeList clicked
                // OPTIONS: Kick + Cancel + Go to profile page
                
                var selectedUser = self.attendeeListAsUsers[indexPath.row]
                
                // Go to Profile
                let profilePageAction = UIAlertAction(title: "Go to Profile Page", style: .default) { _ in
                    let vc = UserProfileViewController()
                    vc.userAuth = self.userAuth
                    let person = Person(id: selectedUser.id, name: selectedUser.name, zipCode: selectedUser.zipCode, sportPreferences: Array(selectedUser.sportsPreferences))
                    vc.person = person
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                // Add Friend
                let addFriendAction = UIAlertAction(title: "Add Friend", style: .default) { _ in
                    let db = Firestore.firestore()
                    let selectedUserID = selectedUser.id
                    currUser?.friendList.append(selectedUser.id)
                    db.collection("Users").document(currUserID).updateData(["friendList": currUser?.friendList])
                    selectedUser.friendList.append(currUser!.id)
                    db.collection("Users").document(selectedUserID).updateData(["friendList": selectedUser.friendList])
                }
                
                // promote to Admin
                let promoteAction = UIAlertAction(title: "Promote to admin", style: .default) { _ in
                    let userID = self.attendeeListAsUsers[indexPath.row].id
                    self.event?.adminsList.append(userID)
                    let db = Firestore.firestore()
                    let id = self.event?.id
                    db.collection("Events").document(id ?? "").updateData(["adminsList":self.event?.adminsList])
                    
                    //PROMOTE NOTIFICATION
                    Task{
                        var notificationID = ""
                        let eventName = self.event?.name
                        let host_name = self.event?.eventHostName
                        var notifsm = NotificationMethods()
                        try await notificationID = notifsm.createNotification(type: .promote, id: currUserID, event_name: eventName ?? "", host_name: host_name ?? "", event_id: self.event?.id ?? "")
                        print(notificationID)
                        print("Promote NOTIFICATION CREATED")
                        selectedUser.notifications.insert(notificationID, at: 0)
                        try await db.collection("Users").document(userID).updateData(["notifications":selectedUser.notifications ?? []])
                    }
                }
                
                
                // promote to Event Host
                
                let promoteToHostAction = UIAlertAction(title: "Promote to event host", style: .default) { _ in
                    let userID = self.attendeeListAsUsers[indexPath.row].id
                    let user = self.attendeeListAsUsers[indexPath.row]
                    
                    let eventHostAlertController = UIAlertController(title: "Event Host Promotion", message: "Are you sure you want to promote \(user.name) to host?", preferredStyle: .alert)
                    
                    // Promote
                    let promoteEventHostAction = UIAlertAction(title: "Promote", style: .default) { _ in
                        
                        // change the real event host, new event host, and event
                        // updates DB
                        // returns an EventHighLevel
                        Task {
                            self.event = await currUser?.promoteNewHost(forEventID: self.event?.id ?? "", newHostID: userID)
                            print("Promoting new user to host")
                        }
                        // push out of the event
                        self.navigationController?.popViewController(animated: true)
                        
                        let alertC2 = UIAlertController(title: "Successful promotion", message: "\(user.name) was successfully promoted as host!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertC2.addAction(okAction)
                        self.present(alertC2, animated: true, completion: nil)
                    }
                    
                    // Cancel
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                        print("User cancelled")
                    }
                    
                    eventHostAlertController.addAction(promoteEventHostAction)
                    eventHostAlertController.addAction(cancelAction)
                    self.present(eventHostAlertController, animated: true, completion: nil)
                }
                
                
                
                // kick user
                let kickAction = UIAlertAction(title: "Kick", style: .destructive) { _ in
                    // Get User ID of user that was clicked on
                    let userID = self.attendeeListAsUsers[indexPath.row].id
                    //Remove User ID from Event Attendee List
                    if let index = self.event?.attendeeList.firstIndex(of: userID) {
                        self.event?.attendeeList.remove(at: index)
                    }
                    // Update DB
                    let db = Firestore.firestore()
                    let id = self.event?.id
                    db.collection("Events").document(id ?? "").updateData(["attendeeList":self.event?.attendeeList])
                    print("USER KICKED")
                    // Remove EventID from Users Events Attending,update DB
                    self.attendeeListAsUsers[indexPath.row].leaveEvent(eventID: id ?? "")
                    // TODO ANDREW SEND NOTIFICATION to kicked user
                    self.updateLists()
                    //PROMOTE NOTIFICATION
                    Task{
                        var notificationID = ""
                        let eventName = self.event?.name
                        let host_name = self.event?.eventHostName
                        var notifsm = NotificationMethods()
                        try await notificationID = notifsm.createNotification(type: .kick, id: currUserID, event_name: eventName ?? "", host_name: host_name ?? "", event_id: self.event?.id ?? "")
                        print(notificationID)
                        print("Kick NOTIFICATION CREATED")
                        selectedUser.notifications.insert(notificationID, at: 0)
                        try await db.collection("Users").document(userID).updateData(["notifications":selectedUser.notifications ?? []])
                    }
                }
                
                // cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    print("User cancelled")
                }
                alertController.addAction(profilePageAction)
                if (currUser!.id != selectedUser.id && !currUser!.friendList.contains(selectedUser.name)) {
                    alertController.addAction(addFriendAction)
                }
                alertController.addAction(kickAction)
                alertController.addAction(cancelAction)
                if (selectedUser.id != event?.eventHost) {
                    alertController.addAction(promoteAction)
                }
                if (currUserID == event?.eventHost) {
                    if (selectedUser.id != event?.eventHost) {
                        alertController.addAction(promoteToHostAction)
                    }
                }
                
                
            } else {
                // requestList clicked
                // host / admin access only
                // OPTIONS: Accept + Reject
                
                var selectedUser = self.requestListAsUsers[indexPath.row]
                
                let acceptAction = UIAlertAction(title: "Accept", style: .default) { _ in
                    // put the ACCEPT function here
                    let userID = self.event?.requestList[indexPath.row]
                    self.event?.acceptUser(acceptUser: userID ?? "") // also updates the DB
                    self.updateLists()
                    
                    // Successfully Accepted
                    let acceptedController = UIAlertController(title: "Successfully Accepted", message: "User was accepted into \(self.event?.name ?? "the event")", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    }
                    acceptedController.addAction(okAction)
                    self.present(acceptedController, animated: true, completion: nil)
                    
                    // TODO ANDREW send notification of accept to userID
                    
                    let eventName = self.event?.name
                    let host_name = self.event?.eventHostName
                    let notifsm = NotificationMethods()
                    var notificationID = ""
                    let db = Firestore.firestore()
                    // Create new Join Notification
                    Task{
                        try await notificationID = notifsm.createNotification(type: .join, id: userID ?? "", event_name: eventName ?? "", host_name: host_name ?? "", event_id: self.event?.id ?? "")
                        print(notificationID)
                        print("NOTIFICATION CREATED")
                        selectedUser.notifications.insert(notificationID, at: 0)
                        try await db.collection("Users").document(userID ?? "").updateData(["notifications":selectedUser.notifications ?? []])
                    }
                    //Create new Joined My Event Notification
                    Task{
                        try await notificationID = notifsm.createNotification(type: .joinedMyEvent, id: currUserID ?? "", event_name: eventName ?? "", host_name: host_name ?? "", event_id: self.event?.id ?? "")
                        print(notificationID)
                        print("NOTIFICATION CREATED")
                        currUser?.notifications.insert(notificationID, at: 0)
                        try await db.collection("Users").document(currUserID ?? "").updateData(["notifications":currUser?.notifications ?? []])
                    }
                }
                
                let rejectAction = UIAlertAction(title: "Reject", style: .destructive) { _ in
                    // put the REJECT function here
                    let userID = self.event?.requestList[indexPath.row]
                    self.event?.rejectUser(rejectUser: userID ?? "") // also updates the DB
                    self.updateLists()
                    
                    // Successfully Rejected
                    let rejectedController = UIAlertController(title: "Rejected", message: "User was rejected from \(self.event?.name ?? "the event")", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    }
                    rejectedController.addAction(okAction)
                    self.present(rejectedController, animated: true, completion: nil)
                    
                    // TODO ANDREW send notification of reject to userID
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    print("User cancelled")
                }
                alertController.addAction(acceptAction)
                alertController.addAction(rejectAction)
                alertController.addAction(cancelAction)
                
            }
            present(alertController, animated: true, completion: nil)
            
            
        } else {
            var selectedUser = self.attendeeListAsUsers[indexPath.row]
            
            // for anyone not the host
            let alertController = UIAlertController(title: "Alert", message: "Choose an action:", preferredStyle: .alert)
            
            if (tableView.tag == 1) {
                // attendeeList clicked
                let profilePageAction = UIAlertAction(title: "Go to Profile Page", style: .default) { _ in
                    let vc = UserProfileViewController()
                    vc.userAuth = self.userAuth
                    let person = Person(id: selectedUser.id, name: selectedUser.name, zipCode: selectedUser.zipCode, sportPreferences: Array(selectedUser.sportsPreferences))
                    vc.person = person
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                let addFriendAction = UIAlertAction(title: "Add Friend", style: .default) { _ in
                    let db = Firestore.firestore()
                    let selectedUserID = selectedUser.id
                    currUser?.friendList.append(selectedUser.id)
                    db.collection("Users").document(currUserID).updateData(["friendList": currUser?.friendList])
                    selectedUser.friendList.append(currUser!.id)
                    db.collection("Users").document(selectedUserID).updateData(["friendList": selectedUser.friendList])
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    print("User cancelled")
                }
                if (currUser!.id != selectedUser.id && !currUser!.friendList.contains(selectedUser.name)) {
                    alertController.addAction(addFriendAction)
                }
                alertController.addAction(profilePageAction)
                alertController.addAction(cancelAction)
                
                
            } else {
                // requestList clicked
                var selectedUser = self.requestListAsUsers[indexPath.row]
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    print("User cancelled")
                }
                alertController.addAction(cancelAction)
            }
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc private func buttonTouchDown() {
        editEventButton.backgroundColor = .darkGray
    }

    @objc private func buttonTouchUp() {
        editEventButton.backgroundColor = .sportGold
    }
}

#Preview {
    SingleEventViewController()
}
