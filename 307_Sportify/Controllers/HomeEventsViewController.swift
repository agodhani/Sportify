//
//  HomeEventsViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/28/23.
//

import UIKit
import SwiftUI

struct HomeEventsViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = HomeEventsViewController
    @ObservedObject var allEvents = AllEvents()
    var userAuth: UserAuthentication
    
    init(userAuth: UserAuthentication) {
        self.userAuth = userAuth
    }
    
    func makeUIViewController(context: Context) -> HomeEventsViewController {
        allEvents.getEvents()
        let vc = HomeEventsViewController()
        // Do some configurations here if needed.
        vc.userAuth = userAuth
        return vc
    }
    
    func updateUIViewController(_ uiViewController: HomeEventsViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
protocol AllEventsDelegate: AnyObject {
    func eventsDidUpdate()
}

class HomeEventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AllEventsDelegate, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    var userAuth : UserAuthentication?
    @ObservedObject var allEvents = AllEvents()
    private var searching = false;
    private var filterSports = false;
    private var filterMaxParticipants = false;
    var selectedSport: Int?
    var selectedParticipants: Int?
    let sportList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash", "None"]
    let numberList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching || filterSports || filterMaxParticipants) {
            let eventz = allEvents.filteredEvents
            let counter = eventz.count
            return counter
        } else {
            let eventz = allEvents.events
            let counter = eventz.count
            return counter
        }
        
    }
    //filter table views
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(searching || filterSports || filterMaxParticipants) {
            let eventz = allEvents.filteredEvents
            cell.textLabel?.text = eventz[indexPath.row].name
            return cell
        } else {
            let eventz = allEvents.events
            cell.textLabel?.text = eventz[indexPath.row].name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching || filterSports || filterMaxParticipants {
            let selectedEvent = allEvents.filteredEvents[indexPath.row]
            let vc = SingleEventViewController()
            vc.userAuth = self.userAuth
            vc.event = selectedEvent
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let selectedEvent = allEvents.events[indexPath.row]
            let vc = SingleEventViewController()
            vc.userAuth = self.userAuth
            vc.event = selectedEvent
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allEvents.getEvents()
    }
    
    private var myEventsText: UITextView = {
        let text = UITextView()
        
        let attributedString = NSMutableAttributedString.init(string: "EVENTS")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor(white: 1, alpha: 1), range: NSRange.init(location: 0, length: attributedString.length))
        text.attributedText = attributedString
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 40, weight: .bold)
        text.toggleUnderline(true)
        return text
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
        if sender.isOn {
            searchBar.placeholder = "Location"
            filterHostSlider.isOn = false;
            filterDateSwitch.isOn = false;
        } else if(filterHostSlider.isOn == false && filterDateSwitch.isOn == false && searchBar.placeholder == "Location") {
            searchBar.placeholder = "Event Name"
        }
    }
    
    //filtering date
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    private let filterDateSwitch: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    @objc func switchDateSliderChanged(_ sender: UISwitch) {
        if sender.isOn {
            searchBar.placeholder = "Date"
            filterHostSlider.isOn = false;
            filterLocationSlider.isOn = false;
        } else if(filterHostSlider.isOn == false && filterLocationSlider.isOn == false && searchBar.placeholder == "Date") {
            searchBar.placeholder = "Event Name"
        }
    }
    
    
    //filtering event Host
    private let eventHostLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Host"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    private let filterHostSlider: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    @objc func switchHostSliderChanged(_ sender: UISwitch) {
        if sender.isOn {
            searchBar.placeholder = "Event Host"
            filterLocationSlider.isOn = false;
            filterDateSwitch.isOn = false;
        } else if(filterHostSlider.isOn == false && filterDateSwitch.isOn == false && searchBar.placeholder == "Event Host") {
            searchBar.placeholder = "Event Name"
        }
    }
    
    //pickers
    // sport tag = 1
    private var sportPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 1
        return picker
    }()
    
    // number tag = 2
    private var numberMaxParticipants: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 2
        return picker
    }()
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return sportList.count
        } else {
            return numberList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView.tag == 1) {
            let item = sportList[row]
            return item
        } else {
            let item = numberList[row]
            let itemString = String(item)
            return itemString
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if (pickerView.tag == 1) {
            return NSAttributedString(string: sportList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.sportGold])
        } else {
            return NSAttributedString(string: String(numberList[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.sportGold])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 { // Sport Picker
            selectedSport = row
            if(row == 16) {
                filterSports = false
                eventsDidUpdate()
            } else {
                filterSports = true
                if(searching) {
                    allEvents.filteredEvents = allEvents.filteredEvents.filter({event in
                        event.sport == row})
                    eventsDidUpdate()
                } else {
                    allEvents.filteredEvents = allEvents.events.filter({event in
                        event.sport == row})
                    eventsDidUpdate()
                }
            }
            
        } else if pickerView.tag == 2 { // Number Picker
            selectedParticipants = numberList[row]
            if(row == 0) {
                filterMaxParticipants = false
                eventsDidUpdate()
            } else {
                filterMaxParticipants = true
                if(searching) {
                    allEvents.filteredEvents = allEvents.filteredEvents.filter({event in
                        event.maxParticipants == row})
                    eventsDidUpdate()
                } else {
                    allEvents.filteredEvents = allEvents.events.filter({event in
                        event.maxParticipants == row})
                    eventsDidUpdate()
                }
            }
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    //searchBar filtering
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Event Name"
        searchBar.barTintColor = .white
        return searchBar
    }()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty) {
            searching = false
        } else {
            searching = true
        }
        if(filterLocationSlider.isOn) {
            if(filterSports || filterMaxParticipants) {
                allEvents.filteredEvents = allEvents.filteredEvents.filter({event in event.location.lowercased()
                    .contains(searchText.lowercased())})
                eventsDidUpdate()
            } else {
                allEvents.filteredEvents = allEvents.events.filter({event in event.location.lowercased()
                    .contains(searchText.lowercased())})
                eventsDidUpdate()
            }
        } else if(filterHostSlider.isOn) {
            if(filterSports || filterMaxParticipants) {
                allEvents.filteredEvents = allEvents.filteredEvents.filter({event in event.eventHostName.lowercased()
                    .contains(searchText.lowercased())})
                eventsDidUpdate()
            } else {
                allEvents.filteredEvents = allEvents.events.filter({event in event.eventHostName.lowercased()
                    .contains(searchText.lowercased())})
                eventsDidUpdate()
            }
        } else if(filterDateSwitch.isOn) {
            if(filterSports || filterMaxParticipants) {
                allEvents.filteredEvents = allEvents.filteredEvents.filter({event in event.date.formatted().lowercased()
                    .contains(searchText.lowercased())})
                eventsDidUpdate()
            } else {
                allEvents.filteredEvents = allEvents.events.filter({event in event.date.formatted().lowercased()
                    .contains(searchText.lowercased())})
                eventsDidUpdate()
            }
        } else {
            if(filterSports || filterMaxParticipants) {
                allEvents.filteredEvents = allEvents.filteredEvents.filter({event in event.name.lowercased()
                    .contains(searchText.lowercased())})
                eventsDidUpdate()
            } else {
                allEvents.filteredEvents = allEvents.events.filter({event in event.name.lowercased()
                    .contains(searchText.lowercased())})
                eventsDidUpdate()
            }
        }
    }
    
    private var sportText: UITextView = {
        let text = UITextView()
        text.text = "Sport"
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 15, weight: .regular)
        text.isEditable = false
        return text
    }()
    
    private var maxParticipantsText: UITextView = {
        let text = UITextView()
        text.text = "Max Participants"
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 15, weight: .regular)
        text.isEditable = false
        return text
    }()
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    func eventsDidUpdate() {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allEvents.getEvents()
        view.addSubview(myEventsText)
        view.addSubview(searchBar)
        view.addSubview(locationLabel)
        view.addSubview(eventHostLabel)
        view.addSubview(dateLabel)
        view.addSubview(filterHostSlider)
        view.addSubview(filterLocationSlider)
        view.addSubview(filterDateSwitch)
        
        view.addSubview(sportText)
        sportPicker.tag = 1
        sportPicker.delegate = self
        sportPicker.dataSource = self
        view.addSubview(sportPicker)
        sportPicker.center = self.view.center
        sportPicker.selectRow(16, inComponent: 0, animated: false)
        
        numberMaxParticipants.tag = 2
        numberMaxParticipants.delegate = self
        numberMaxParticipants.dataSource = self
        numberMaxParticipants.center = self.view.center
        view.addSubview(numberMaxParticipants)
        view.addSubview(maxParticipantsText)

        filterDateSwitch.addTarget(self, action: #selector(switchDateSliderChanged), for: .valueChanged)
        filterLocationSlider.addTarget(self, action: #selector(switchLocationSliderChanged), for: .valueChanged)
        filterHostSlider.addTarget(self, action: #selector(switchHostSliderChanged), for: .valueChanged)
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        allEvents.delegate = self
        view.addSubview(table)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        view.frame = view.bounds
        view.backgroundColor = .black
        myEventsText.frame = CGRect(x: -50,
                                    y: 0,
                                    width: size,
                                    height: size)
        searchBar.frame = CGRect(x:0, y: 50, width: view.bounds.size.width, height: 44)
        table.frame = CGRect(x: (view.width - size) / 2,
                             y: 250,
                             width: size,
                             height: size * 1.3)
        locationLabel.frame = CGRect(x: 50,
                                    y: 95,
                                    width: size,
                                    height: 50)
        filterLocationSlider.frame = CGRect(x:150,
                                       y: 100,
                                       width: 1,
                                       height: 1)
        dateLabel.frame = CGRect(x: 250,
                                    y: 95,
                                    width: size,
                                    height: 50)
        filterDateSwitch.frame = CGRect(x:298,
                                       y: 100,
                                       width: 1,
                                       height: 1)
        eventHostLabel.frame = CGRect(x: 50,
                                    y: 135,
                                    width: size,
                                    height: 50)
        filterHostSlider.frame = CGRect(x:150,
                                       y: 140,
                                       width: 1,
                                       height: 1)
        sportText.frame = CGRect(x: -15,
                                  y: 170,
                                  width: 180,
                                  height: 50)
        
        sportPicker.frame = CGRect(x: 50,
                                    y: 190,
                                    width: 180,
                                    height: 50)
        sportText.frame = CGRect(x: -15,
                                  y: 170,
                                  width: 100,
                                  height: 50)
        
        sportPicker.frame = CGRect(x: -15,
                                    y: 180,
                                    width: 150,
                                    height: 50)
        maxParticipantsText.frame = CGRect(x: 125,
                                  y: 170,
                                  width: 180,
                                  height: 50)
        
        numberMaxParticipants.frame = CGRect(x: 175,
                                    y: 190,
                                    width: 180,
                                    height: 50)
    }
}

#Preview {
    HomeEventsViewController()
}
