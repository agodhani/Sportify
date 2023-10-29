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


class HomeEventsViewController: UIViewController, UITableViewDataSource {
    @ObservedObject var allEvents = AllEvents()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(getEvs.shared.events)
        let eventz = getEvs.shared.events
        let counter = eventz.count
        return counter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let eventz = getEvs.shared.events
        cell.textLabel?.text = eventz[indexPath.row].name
        return cell
    }
    
   
    
    
    private var myEventsText: UITextView = {
        let text = UITextView()
        
        let attributedString = NSMutableAttributedString.init(string: "EVENTS")
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
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allEvents.getEvents()
        view.addSubview(myEventsText)
        table.dataSource = self
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
        table.frame = CGRect(x: (view.width - size) / 2,
                             y: 250,
                             width: size,
                             height: size * 1.3)
    }
}

#Preview {
    HomeEventsViewController()
}
