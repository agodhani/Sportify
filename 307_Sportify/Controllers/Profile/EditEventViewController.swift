//
//  EditEventViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/29/23.
//

import Foundation
import UIKit

class EditEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var event: EventHighLevel?
    
    // TODO - BACK BUTTON
    
    let sportList = Sport.sportData()
    let numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
    let eventsm = EventMethods()
    private var userAuth = UserAuthentication()
    var selectedSport: Int?
    var selectedNumber: Int?
    
    var allFieldsFilled = true
    var eventNameFilled = true
    var descriptionFilled = true
    var locationFilled = true
    
    private var editEventText: UITextView = {
        let text = UITextView()
        text.text = "Edit Event"
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
        field.isSecureTextEntry = true
        return field
    }()
    
    private var randomButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "questionmark.square.fill"), for: .normal)
        return button
    }()
    
    private var revealButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        return button
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
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .compact
        }
        datePicker.tintColor = .sportGold
        datePicker.backgroundColor = .clear
        return datePicker
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = .red
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
        
        eventNameField.text = event?.name
        descriptionField.text = event?.description
        locationField.text = event?.location
        codeField.text = event?.code
        isPrivateSlider.setOn(event?.privateEvent ?? false, animated: true)
        
        // Add subviews to view
        view.addSubview(editEventText)
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
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown) // When clicked or touched down
        saveButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside) // When clicked or touched up inside
        saveButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside) // When clicked or touched up outside
        view.addSubview(saveButton)
        
        view.addSubview(datePicker)
        
        revealButton.addTarget(self, action: #selector(revealButtonTapped), for: .touchUpInside)
        view.addSubview(revealButton)
        
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        view.addSubview(randomButton)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        view.addSubview(deleteButton)
        
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.frame = view.bounds
        let size = view.width / 1.2
        
        editEventText.frame = CGRect(x: (view.width - size) / 2,
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
        
        revealButton.frame = CGRect(x: -10,
                                    y: 400,
                                    width: 50,
                                    height: 50)
        
        randomButton.frame = CGRect(x: 350,
                                    y: 400,
                                    width: 50,
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
        
        
        datePicker.frame = CGRect(x: -20,
                                  y: 450,
                                  width: size,
                                  height: size)
        
        privateText.frame = CGRect(x: 20,
                                    y: 675,
                                    width: 150,
                                    height: 100)
        
        isPrivateSlider.frame = CGRect(x: 175,
                                       y: 680,
                                       width: 150,
                                       height: 100)
        
        saveButton.frame = CGRect(x: (view.width - 180) / 2,
                                         y: 750,
                                         width: 180,
                                         height: 60)
        
        deleteButton.frame = CGRect(x: 300,
                                         y: 100,
                                         width: 60,
                                         height: 30)
    }
    
    @objc private func saveButtonTapped() {
        Task {
            
            if (allFieldsFilled) {
                
                try await eventsm.modifyEvent(eventID: event?.id ?? "", eventName: eventNameField.text ?? "", date: datePicker.date, location: locationField.text ?? "", attendeeList: event?.attendeeList ?? [String](), privateEvent: isPrivateSlider.isOn, maxParticipants: selectedNumber ?? 25, adminsList: Set<User>(), eventHostID: event?.eventHost ?? "nouid", code: codeField.text ?? "", blackList: Set<User>(), requestList: event?.requestList ?? [String](), description: descriptionField.text ?? "")
                
                navigationController?.popViewController(animated: true)

                let alertController = UIAlertController(title: "Event Modified", message: "Your event was successfully modified!", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                
            } else {
                // Fields aren't filled, show a popup (alert)
                let alertController = UIAlertController(title: "Fields Incomplete", message: "Please fill out all the fields to create an event.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                present(alertController, animated: true, completion: nil)
            }

        }
    }
    
    @objc private func revealButtonTapped() {
        codeField.isSecureTextEntry = !codeField.isSecureTextEntry
        if (codeField.isSecureTextEntry) {
            // if hidden
            revealButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        } else {
            // if not hidden
            revealButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    @objc private func buttonTouchDown() {
        saveButton.backgroundColor = .darkGray
    }

    @objc private func buttonTouchUp() {
        saveButton.backgroundColor = .sportGold
    }
    
    @objc private func randomButtonTapped() {
        codeField.text = event?.generateRandomCode(length: 10)
    }
    
    @objc private func deleteButtonTapped() {
        
        let alertController = UIAlertController(title: "Delete Event", message: "Are you sure you want to delete this event?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style:.destructive) { _ in
            Task {
                await self.eventsm.deleteEvent(eventID: self.event?.id ?? "")
            }
            
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.popViewController(animated: true)
            let alertC2 = UIAlertController(title: "Delete Event", message: "Your event was successfully deleted", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertC2.addAction(okAction)
            self.present(alertC2, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("User cancelled")
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}

#Preview {
    EditEventViewController()
}
