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
    
    func makeUIViewController(context: Context) -> HomeEventsViewController {
        allEvents.getEvents()
        let vc = HomeEventsViewController()
        // Do some configurations here if needed.
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: HomeEventsViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
protocol AllEventsDelegate: AnyObject {
    func eventsDidUpdate()
}

class HomeEventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AllEventsDelegate, UISearchBarDelegate {
    @ObservedObject var allEvents = AllEvents()
    private var searching = false;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching) {
            let eventz = allEvents.filteredEvents
            let counter = eventz.count
            return counter
        } else {
            let eventz = allEvents.events
            let counter = eventz.count
            return counter
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(searching) {
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
        let selectedEvent = allEvents.events[indexPath.row]
        let vc = SingleEventViewController()
        vc.event = selectedEvent
        navigationController?.pushViewController(vc, animated: true)
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
        } else if(filterHostSlider.isOn == false && searchBar.placeholder == "Location") {
            searchBar.placeholder = "Event Name"
        }
    }
    
    
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
        } else if(filterHostSlider.isOn == false && searchBar.placeholder == "Event Host") {
            searchBar.placeholder = "Event Name"
        }
    }
    
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
        allEvents.filteredEvents = allEvents.events.filter({event in event.name.lowercased()
            .contains(searchText.lowercased())})
        eventsDidUpdate()
    }
    
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
        view.addSubview(filterHostSlider)
        view.addSubview(filterLocationSlider)
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
                                    y: 50,
                                    width: size,
                                    height: size)
        searchBar.frame = CGRect(x:0, y: 100, width: view.bounds.size.width, height: 44)
        table.frame = CGRect(x: (view.width - size) / 2,
                             y: 250,
                             width: size,
                             height: size * 1.3)
        locationLabel.frame = CGRect(x: 50,
                                    y: 145,
                                    width: size,
                                    height: 50)
        filterLocationSlider.frame = CGRect(x:298,
                                       y: 150,
                                       width: 1,
                                       height: 1)
        eventHostLabel.frame = CGRect(x: 50,
                                    y: 185,
                                    width: size,
                                    height: 50)
        filterHostSlider.frame = CGRect(x:298,
                                       y: 190,
                                       width: 1,
                                       height: 1)
    }
}

#Preview {
    HomeEventsViewController()
}
