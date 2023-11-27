//
//  AddFriendsViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 11/9/23.
//

import UIKit
import SwiftUI
import Firebase

struct AddFriendsViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AddFriendsViewController
    @ObservedObject var allUsers = AllUsers()
    var userAuth: UserAuthentication
    
    
    init(userAuth: UserAuthentication) {
        self.userAuth = userAuth
        
    }
    
    func makeUIViewController(context: Context) -> AddFriendsViewController {
        allUsers.getUsers()
        let vc = AddFriendsViewController()
        // Do some configurations here if needed.
        vc.userAuth = userAuth
        return vc
    }
    
    func updateUIViewController(_ uiViewController: AddFriendsViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
        
    }
}
protocol AllUsersDelegate: AnyObject {
    func usersDidUpdate()
}

class AddFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AllUsersDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    private var filterLocation = false;
    private var filterSportPreferences = false;
    var userAuth : UserAuthentication?
    @ObservedObject var allUsers = AllUsers()
    var selectedSport: Int?
    let sportList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash", "None"]
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    //filtering location
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    private let filterLocationSlider: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    @objc func switchLocationSliderChanged(_ sender: UISwitch) {
        let thisUser = userAuth?.currUser
        if sender.isOn {
            filterLocation = true
            if(filterSportPreferences) {
                allUsers.filteredUsers = allUsers.filteredUsers.filter({user in
                    user.zipCode == (thisUser?.zipCode ?? "0")
                })
            } else {
                allUsers.filteredUsers = allUsers.users.filter({user in
                    user.zipCode == (thisUser?.zipCode ?? "0")
                })
            }
        } else {
            //need to add this to event home page
            allUsers.filteredUsers = allUsers.users.filter({user in
                user.sportPreferences.contains(selectedSport ?? 16)})
            usersDidUpdate()
            filterLocation = false
        }
        usersDidUpdate()
    }
    
    //sport picker information
    private var sportPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 1
        return picker
    }()
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return sportList.count
        } else {
            return sportList.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView.tag == 1) {
            let item = sportList[row]
            return item
        } else {
            let item = sportList[row]
            let itemString = String(item)
            return itemString
        }
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if (pickerView.tag == 1) {
            return NSAttributedString(string: sportList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.sportGold])
        } else {
            return NSAttributedString(string: String(sportList[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.sportGold])
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let thisUser = userAuth?.currUser
        if pickerView.tag == 1 { // Sport Picker
            selectedSport = row
            if(row == 16) {
                filterSportPreferences = false
                if(filterLocation) {
                    allUsers.filteredUsers = allUsers.users.filter({user in
                        user.zipCode == (thisUser?.zipCode ?? "0")
                    })
                }
                usersDidUpdate()
            } else {
                filterSportPreferences = true
                if(filterLocation) {
                    allUsers.filteredUsers = allUsers.filteredUsers.filter({user in
                        user.sportPreferences.contains(selectedSport ?? 16)})
                    usersDidUpdate()
                } else {
                    allUsers.filteredUsers = allUsers.users.filter({user in
                        user.sportPreferences.contains(selectedSport ?? 16)})
                    usersDidUpdate()
                }
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Table information
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filterLocation || filterSportPreferences) {
            let userz = allUsers.filteredUsers
            let counter = userz.count
            return counter
        } else {
            let userz = allUsers.users
            let counter = userz.count
            return counter
        }
        
    }
    //filter table views
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if (filterLocation || filterSportPreferences) {
            let userz = allUsers.filteredUsers
            cell.textLabel?.text = userz[indexPath.row].name
            return cell
        } else {
            let userz = allUsers.users
            cell.textLabel?.text = userz[indexPath.row].name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (filterLocation || filterSportPreferences) {
            let selectedUser = allUsers.filteredUsers[indexPath.row]
            let vc = UserProfileViewController()
            vc.userAuth = userAuth
            vc.person = selectedUser
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let selectedUser = allUsers.users[indexPath.row]
            let vc = UserProfileViewController()
            vc.userAuth = userAuth
            vc.person = selectedUser
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        allUsers.getUsers()
        table.dataSource = self
        table.delegate = self
        allUsers.delegate = self
        sportPicker.delegate = self
        sportPicker.dataSource = self
        sportPicker.selectRow(16, inComponent: 0, animated: false)
        view.addSubview(locationLabel)
        view.addSubview(filterLocationSlider)
        view.addSubview(sportPicker)
        view.addSubview(table)
        filterLocationSlider.addTarget(self, action: #selector(switchLocationSliderChanged), for: .valueChanged)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
    }
    func usersDidUpdate() {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        view.frame = view.bounds
        view.backgroundColor = .black
        locationLabel.frame = CGRect(x: 50,
                                    y: 95,
                                    width: size,
                                    height: 50)
        filterLocationSlider.frame = CGRect(x: 150,
                                       y: 100,
                                       width: 1,
                                       height: 1)
        table.frame = CGRect(x: 0,
                             y: 240, // was 50
                             width: view.width,
                             height: view.height)
        sportPicker.frame = CGRect(x: 150,
                                    y: 180,
                                    width: 150,
                                    height: 50)
        backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)
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
    
}
