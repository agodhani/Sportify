//
//  CreateEventViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/28/23.
//

import Foundation
import UIKit

class CreateEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let sportList = Sport.sportData()
    let numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
    let eventsm = EventMethods()
    private var userAuth = UserAuthentication()
    var selectedSport: Int?
    var selectedNumber: Int?
    
    var allFieldsFilled = false
    var eventNameFilled = false
    var descriptionFilled = false
    var locationFilled = false
        
    private var newEventText: UITextView = {
        let text = UITextView()
        text.text = "New Event"
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 45, weight: .heavy)
        text.isEditable = false
        return text
    }()
    
    private var eventNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Event Name"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.tintColor = .black
        return field
    }()
    
    private var sportText: UITextView = {
        let text = UITextView()
        text.text = "Sport"
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 30, weight: .heavy)
        text.isEditable = false
        return text
    }()
    
    private var descriptionField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Description"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.tintColor = .black
        return field
    }()
    
    private var locationField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Location"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.tintColor = .black
        return field
    }()
    
    private var codeField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Join Code"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        field.tintColor = .black
        return field
    }()
    
    private var participantsText: UITextView = {
        let text = UITextView()
        text.text = "Participants"
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 30, weight: .heavy)
        text.isEditable = false
        return text
    }()
    // sport tag = 1
    private var sportPicker: UIPickerView = {
        let picker = UIPickerView()
        //picker.backgroundColor = .gray
        picker.tag = 1
        return picker
    }()
    
    // number tag = 2
    private var numberPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = 2
        return picker
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return sportList.count
        } else {
            return numberList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView.tag == 1) {
            let item = sportList[row].name
            return item
        } else {
            let item = numberList[row]
            let itemString = String(item)
            return itemString
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if (pickerView.tag == 1) {
            return NSAttributedString(string: sportList[row].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.sportGold])
        } else {
            return NSAttributedString(string: String(numberList[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.sportGold])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 { // Sport Picker
            selectedSport = row
            
        } else if pickerView.tag == 2 { // Number Picker
            selectedNumber = numberList[row]
        }
    }
    
    private var privateText: UITextView = {
        let text = UITextView()
        text.text = "Private Event:"
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 20, weight: .regular)
        text.isEditable = false
        return text
    }()
    
    private let isPrivateSlider: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private let createEventButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Event", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    func textFieldDidBeginEditing (_ textField: UITextField) {
        if (textField == eventNameField) {
            if (eventNameField.text != "") {
                eventNameFilled = true
            } else {
                eventNameFilled = false
            }
            
        } else if (textField == descriptionField) {
            if (descriptionField.text != "") {
                descriptionFilled = true
            } else {
                descriptionFilled = false
            }
            
        } else if (textField == locationField) {
            if (locationField.text != "") {
                locationFilled = true
            } else {
                locationFilled = false
            }
        }
        
        if (eventNameFilled && descriptionFilled && locationFilled) {
            allFieldsFilled = true
        } else {
            allFieldsFilled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == eventNameField) {
            if (eventNameField.text != "") {
                eventNameFilled = true
            } else {
                eventNameFilled = false
            }
            
        } else if (textField == descriptionField) {
            if (descriptionField.text != "") {
                descriptionFilled = true
            } else {
                descriptionFilled = false
            }
            
        } else if (textField == locationField) {
            if (locationField.text != "") {
                locationFilled = true
            } else {
                locationFilled = false
            }
        }
        
        if (eventNameFilled && descriptionFilled && locationFilled) {
            allFieldsFilled = true
        } else {
            allFieldsFilled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        eventNameField.delegate = self
        descriptionField.delegate = self
        locationField.delegate = self
        
        // Add subviews to view
        view.addSubview(newEventText)
        view.addSubview(eventNameField)
        view.addSubview(descriptionField)
        view.addSubview(locationField)
        view.addSubview(codeField)
        
        view.addSubview(sportText)
        sportPicker.tag = 1
        sportPicker.delegate = self as UIPickerViewDelegate
        sportPicker.dataSource = self as UIPickerViewDataSource
        view.addSubview(sportPicker)
        sportPicker.center = self.view.center
        
        view.addSubview(participantsText)
        numberPicker.tag = 2
        numberPicker.delegate = self as UIPickerViewDelegate
        numberPicker.dataSource = self as UIPickerViewDataSource
        view.addSubview(numberPicker)
        numberPicker.center = self.view.center
        
        view.addSubview(privateText)
        view.addSubview(isPrivateSlider)
        
        createEventButton.addTarget(self, action: #selector(createEventButtonTapped), for: .touchUpInside)
        createEventButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown) // When clicked or touched down
        createEventButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside) // When clicked or touched up inside
        createEventButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside) // When clicked or touched up outside'
        view.addSubview(createEventButton)
        
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.frame = view.bounds
        let size = view.width / 1.2
        
        newEventText.frame = CGRect(x: (view.width - size) / 2,
                                    y: 75,
                                    width: size,
                                    height: size)
        
        eventNameField.frame = CGRect(x: (view.width - size) / 2,
                                  y: 160,
                                  width: size,
                                  height: 50)
        
        descriptionField.frame = CGRect(x: (view.width - size) / 2,
                                  y: 240,
                                  width: size,
                                  height: 50)
        
        locationField.frame = CGRect(x: (view.width - size) / 2,
                                    y: 320,
                                    width: size,
                                    height: 50)
        
        codeField.frame = CGRect(x: (view.width - size) / 2,
                                    y: 400,
                                    width: size,
                                    height: 50)
        
        sportText.frame = CGRect(x: -15,
                                  y: 460,
                                  width: 180,
                                  height: 50)
        
        sportPicker.frame = CGRect(x: -15,
                                    y: 475,
                                    width: 180,
                                    height: 100)
        
        participantsText.frame = CGRect(x: 180,
                                    y: 460,
                                    width: 200,
                                    height: 100)
        
        numberPicker.frame = CGRect(x: 200,
                                    y: 475,
                                    width: 180,
                                    height: 100)
        
        
        privateText.frame = CGRect(x: 20,
                                    y: 610,
                                    width: 150,
                                    height: 100)
        
        isPrivateSlider.frame = CGRect(x: 175,
                                       y: 615,
                                       width: 150,
                                       height: 100)
        
        createEventButton.frame = CGRect(x: (view.width - 180) / 2,
                                         y: 680,
                                         width: 180,
                                         height: 60)
    }
    
    @objc private func createEventButtonTapped() {
        Task {
            
            if (allFieldsFilled) {
                
                try await eventsm.createEvent(eventName: eventNameField.text ?? "", sport: selectedSport ?? 0, maxParticipants: selectedNumber ?? 0, description: descriptionField.text ?? "", location: locationField.text ?? "", privateEvent: isPrivateSlider.isOn, id: userAuth.currUser?.id ?? "nouid", code: codeField.text ?? "") // TODO create with code?
                
                let alertController = UIAlertController(title: "Event Created", message: "Your event was successfully created!", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                
                let vc = EventsViewController()
                navigationController?.pushViewController(vc, animated: true)
                
                
            } else {
                // Fields aren't filled, show a popup (alert)
                let alertController = UIAlertController(title: "Fields Incomplete", message: "Please fill out all the fields to create an event.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
            }

        }
    }
    
    @objc private func buttonTouchDown() {
        createEventButton.backgroundColor = .darkGray
    }

    @objc private func buttonTouchUp() {
        createEventButton.backgroundColor = .sportGold
    }
    
}

#Preview {
    CreateEventViewController()
}
