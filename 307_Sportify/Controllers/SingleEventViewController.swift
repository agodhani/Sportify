//
//  SingleEventViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/28/23.
//

import UIKit

class SingleEventViewController: UIViewController {
    var event: EventHighLevel?
    private var sportList = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash", "Error"]
    
    private var eventNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 30, weight: .bold)
        text.toggleUnderline(true)
        return text
    }()
    
    private var hostNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var locationNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .white
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var sportNameText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    private var maxParticipantsText: UITextView = {
        let text = UITextView()
        text.isEditable = false;
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .regular)
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(eventNameText)
        view.addSubview(hostNameText)
        view.addSubview(locationNameText)
        view.addSubview(sportNameText)
        view.addSubview(maxParticipantsText)
        
        
        eventNameText.text = event?.name ?? "Error"
        hostNameText.text = event?.eventHost ?? "Event Host Error"
        locationNameText.text = event?.location ?? "Location Error"
        sportNameText.text = sportList[event?.sport ?? 16]
        maxParticipantsText.text = String(event?.maxParticipants ?? 0)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        view.frame = view.bounds
        view.backgroundColor = .black
        eventNameText.frame = CGRect(x: 0,
                                    y: 100,
                                    width: size,
                                    height: size)
        hostNameText.frame = CGRect(x: 0,
                                    y: 150,
                                    width: size,
                                    height: size)
        locationNameText.frame = CGRect(x: 0,
                                    y: 200,
                                    width: size,
                                    height: size)
        sportNameText.frame = CGRect(x: 0,
                                    y: 250,
                                    width: size,
                                    height: size)
        maxParticipantsText.frame = CGRect(x: 0,
                                    y: 300,
                                    width: size,
                                    height: size)
    }
}
