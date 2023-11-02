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
        //Add button
        contentView.addSubview(kickButton)
        kickButton.addTarget(self, action: #selector(tappedKickButton), for: .touchUpInside)
        
        //Set constraints as per your requirements
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
    
    private var eventNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 45, weight: .bold)
        text.toggleUnderline(true)
        return text
    }()
    
    private var descriptionText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var hostNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var locationNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var sportNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var maxParticipantsText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var privateEventText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var eventDateText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    // TODO attendeeList - this may need to be a CollectionView for buttons if want
    // tag = 1
    private let attendeeTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = 1
        //tableView.register(MyCell.self, forCellReuseIdentifier: "MyCell") // uncomment for custom cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    // TODO kick button
    
    // TODO Request list if event host
    // tag = 2
    private let requestTableView: UITableView = {
        let tableView = UITableView()
        tableView.tag = 2
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // TODO join/leave button
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
    
    // TODO edit event button
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
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        view.addSubview(eventNameText)
        view.addSubview(descriptionText)
        view.addSubview(hostNameText)
        view.addSubview(locationNameText)
        view.addSubview(sportNameText)
        view.addSubview(maxParticipantsText)
        view.addSubview(privateEventText)
        view.addSubview(eventDateText)
        view.addSubview(attendeeTableView)
        view.addSubview(requestTableView)
        view.addSubview(joinLeaveButton)
        if (currUserID == event?.eventHost || (event?.adminsList.contains(currUserID) ?? false)) {
            // if the user is the host or an admin - display the button
            view.addSubview(editEventButton)
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
        view.frame = view.bounds
        view.backgroundColor = .black
        
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
        
        eventNameText.frame = CGRect(x: 25,
                                    y: 70,
                                    width: size,
                                    height: size)
        
        descriptionText.frame = CGRect(x: 25,
                                    y: 180,
                                    width: size,
                                    height: size)
        
        hostNameText.frame = CGRect(x: 25,
                                    y: 210,
                                    width: size,
                                    height: size)
        locationNameText.frame = CGRect(x: 25,
                                    y: 240,
                                    width: size,
                                    height: size)
        sportNameText.frame = CGRect(x: 25,
                                    y: 270,
                                    width: size,
                                    height: size)
        maxParticipantsText.frame = CGRect(x: 25,
                                    y: 400,
                                    width: size,
                                    height: size)
        privateEventText.frame = CGRect(x: 25,
                                    y: 300,
                                    width: size,
                                    height: size)
        eventDateText.frame = CGRect(x: 25,
                                    y: 330,
                                    width: size,
                                    height: size)
        attendeeTableView.frame = CGRect(x: 25,
                                    y: 450,
                                    width: size,
                                    height: 100)
        requestTableView.frame = CGRect(x: 25,
                                    y: 600,
                                    width: size,
                                    height: 100)
        joinLeaveButton.frame = CGRect(x: 50,
                                       y: 750,
                                       width: 80,
                                       height: 45)
        editEventButton.frame = CGRect(x: 150,
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
    
    @objc private func tappedJoinLeaveButton() {
        var currUserID = userAuth?.currUser?.id ?? ""
        var currUser = userAuth?.currUser
        if (event?.userIsAttending(userID: currUserID) == false) {
            // TODO JOIN - HERE
            // update user
            // update DB user
            // update event
            // update DB event
            
            if (event?.privateEvent ?? false) {
                // if it's a private event - prompt for join code
                
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
                        
                        let joinedAlertController = UIAlertController(title: "Success", message: "You've successfully joined the event.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        joinedAlertController.addAction(okAction)
                        self?.present(joinedAlertController, animated: true, completion: nil)
                        
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
                present(alertController, animated: true, completion: nil)
                updateLists()
                
            } else {
                // not a private event - join the event
                self.event?.joinEvent(id: currUserID)
                let db = Firestore.firestore()
                let id = (self.event?.id)!
                db.collection("Events").document(id).updateData(["attendeeList":self.event?.attendeeList ?? []])
                print("EVENT JOINED")
                currUser?.joinEvent(eventID: self.event?.id ?? "")
                
                let joinedAlertController = UIAlertController(title: "Success", message: "You've successfully joined the event.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                joinedAlertController.addAction(okAction)
                present(joinedAlertController, animated: true, completion: nil)
                updateLists()
            }
            
            
        } else {
            // TODO LEAVE - HERE
            //Remove User from Attendee List
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
            
            let leaveAlertController = UIAlertController(title: "Success", message: "You've successfully left the event.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            leaveAlertController.addAction(okAction)
            present(leaveAlertController, animated: true, completion: nil)
            updateLists()
            
        }
        
    }
    
    @objc private func tappedEditEventButton() { // TODO EditEventViewController()
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
        // TODO
        // indexPath.row = index of the array
        Task {
            var user = await userAuth?.getCurrUser()
        }
        var currUser = userAuth?.currUser
        let currUserID = userAuth?.currUser?.id ?? ""
        var selectedUser = self.attendeeListAsUsers[indexPath.row]
        if (currUserID == event?.eventHost || (event?.adminsList.contains(currUserID) ?? false)) {
            
            let alertController = UIAlertController(title: "Alert", message: "Choose an action:", preferredStyle: .alert)
            
            if (tableView.tag == 1) {
                // attenedeeList clicked
                // OPTIONS: Kick + Cancel + Go to profile page
                let profilePageAction = UIAlertAction(title: "Go to Profile Page", style: .default) { _ in
                    let vc = ProfileViewController()
                    vc.userAuth.currUser = selectedUser
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                let addFriendAction = UIAlertAction(title: "Add Friend", style: .default) { _ in
                    let db = Firestore.firestore()
                    let selectedUserID = selectedUser.id
                    currUser?.friendList.append(selectedUser.name)
                    db.collection("Users").document(currUserID).updateData(["friendList": currUser?.friendList])
                    selectedUser.friendList.append(currUser!.name)
                    db.collection("Users").document(selectedUserID).updateData(["friendList": selectedUser.friendList])
                }
                let promoteAction = UIAlertAction(title: "Promote", style: .default) { _ in
                    let userID = self.attendeeListAsUsers[indexPath.row].id
                    self.event?.adminsList.append(userID)
                    let db = Firestore.firestore()
                    let id = self.event?.id
                    db.collection("Events").document(id ?? "").updateData(["adminsList":self.event?.adminsList])
                    
                }
                let kickAction = UIAlertAction(title: "Kick", style: .destructive) { _ in
                    // TODO ANDREW - put the kicking function here
                    //Get User ID of user that was clicked on
                    let userID = self.attendeeListAsUsers[indexPath.row].id
                    //Remove User ID from Event Attendee List
                    if let index = self.event?.attendeeList.firstIndex(of: userID) {
                        self.event?.attendeeList.remove(at: index)
                    }
                    //Update DB
                    let db = Firestore.firestore()
                    let id = self.event?.id
                    db.collection("Events").document(id ?? "").updateData(["attendeeList":self.event?.attendeeList])
                    print("USER KICKED")
                    //Remove EventID from Users Events Attending,update DB
                    self.attendeeListAsUsers[indexPath.row].leaveEvent(eventID: id ?? "")
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    print("User cancelled")
                }
                alertController.addAction(profilePageAction)
                if (!currUser!.friendList.contains(selectedUser.name)) {
                    alertController.addAction(addFriendAction)
                }
                alertController.addAction(kickAction)
                alertController.addAction(cancelAction)
                alertController.addAction(promoteAction)
                
                
            } else {
                // requestList clicked
                // OPTIONS: Accept + Reject
                
                let acceptAction = UIAlertAction(title: "Accept", style: .default) { _ in
                    // TODO ANDREW - put the kicking function here
                }
                
                let rejectAction = UIAlertAction(title: "Reject", style: .destructive) { _ in
                    // TODO ANDREW - put the kicking function here
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
            // for anyone not the host
            let alertController = UIAlertController(title: "Alert", message: "Choose an action:", preferredStyle: .alert)
            
            if (tableView.tag == 1) {
                // attendeeList clicked
                let profilePageAction = UIAlertAction(title: "Go to Profile Page", style: .default) { _ in
                    let selectedUser = self.attendeeListAsUsers[indexPath.row]
                    let vc = ProfileViewController()
                    vc.userAuth.currUser = selectedUser
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                let addFriendAction = UIAlertAction(title: "Add Friend", style: .default) { _ in
                    let db = Firestore.firestore()
                    let selectedUserID = selectedUser.id
                    currUser?.friendList.append(selectedUser.name)
                    db.collection("Users").document(currUserID).updateData(["friendList": currUser?.friendList])
                    selectedUser.friendList.append(currUser!.name)
                    db.collection("Users").document(selectedUserID).updateData(["friendList": selectedUser.friendList])
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    print("User cancelled")
                }
                if (!currUser!.friendList.contains(selectedUser.name)) {
                    alertController.addAction(addFriendAction)
                }
                alertController.addAction(profilePageAction)
                alertController.addAction(cancelAction)
                
                
            } else {
                //requestList clicked
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
