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
    var pictureSelected = false
        
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 50)
        return scrollView
    }()
    
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
    
    private var picView: UIImageView = {
        let picView = UIImageView()
        picView.image = UIImage(systemName: "trophy.circle")
        picView.layer.masksToBounds = true
        picView.contentMode = .scaleAspectFit
        picView.layer.borderWidth = 2
        picView.layer.borderColor = UIColor.lightGray.cgColor
        return picView
    }()
    
    private var editPicPrompt: UITextView = {
        let text = UITextView()
        text.text = "Click icon to edit image"
        text.textColor = .sportGold
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 15, weight: .light)
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
            let item = row + 1
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
            selectedNumber = row + 1
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
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .compact
        }
        datePicker.tintColor = .sportGold
        datePicker.backgroundColor = .clear
        return datePicker
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
        view.addSubview(scrollView)
        scrollView.addSubview(newEventText)
        scrollView.addSubview(picView)
        scrollView.addSubview(editPicPrompt)
        scrollView.addSubview(eventNameField)
        scrollView.addSubview(descriptionField)
        scrollView.addSubview(locationField)
        scrollView.addSubview(codeField)
        
        scrollView.addSubview(sportText)
        sportPicker.tag = 1
        sportPicker.delegate = self as UIPickerViewDelegate
        sportPicker.dataSource = self as UIPickerViewDataSource
        scrollView.addSubview(sportPicker)
        sportPicker.center = self.view.center
        
        scrollView.addSubview(participantsText)
        numberPicker.tag = 2
        numberPicker.delegate = self as UIPickerViewDelegate
        numberPicker.dataSource = self as UIPickerViewDataSource
        scrollView.addSubview(numberPicker)
        numberPicker.center = self.view.center
        
        scrollView.addSubview(privateText)
        scrollView.addSubview(isPrivateSlider)
        
        // Make picture tappable
        picView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(eventPicTapped))
        picView.addGestureRecognizer(tap)
        
        createEventButton.addTarget(self, action: #selector(createEventButtonTapped), for: .touchUpInside)
        createEventButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown) // When clicked or touched down
        createEventButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside) // When clicked or touched up inside
        createEventButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside) // When clicked or touched up outside'
        scrollView.addSubview(createEventButton)
        
        scrollView.addSubview(datePicker)
        
        revealButton.addTarget(self, action: #selector(revealButtonTapped), for: .touchUpInside)
        scrollView.addSubview(revealButton)
        
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        scrollView.addSubview(randomButton)
        scrollView.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()

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
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = view.width / 1.2
        backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)
        newEventText.frame = CGRect(x: (view.width - size) / 2,
                                    y: 75,
                                    width: size,
                                    height: 52)
        
        picView.frame = CGRect(x: 120,
                               y: newEventText.bottom + 30,
                               width: scrollView.width / 2.5,
                               height: scrollView.width / 2.5)
        picView.layer.cornerRadius = picView.width / 2
        
        editPicPrompt.frame = CGRect(x: (view.width - size) / 2,
                                     y: picView.bottom + 5,
                                    width: size,
                                    height: 25)
        
        eventNameField.frame = CGRect(x: (view.width - size) / 2,
                                  y: editPicPrompt.bottom + 25,
                                  width: size,
                                  height: 50)
        
        descriptionField.frame = CGRect(x: (view.width - size) / 2,
                                        y: eventNameField.bottom + 20,
                                  width: size,
                                  height: 50)
        
        locationField.frame = CGRect(x: (view.width - size) / 2,
                                     y: descriptionField.bottom + 20,
                                    width: size,
                                    height: 50)
        
        codeField.frame = CGRect(x: (view.width - size) / 2,
                                 y: locationField.bottom + 20,
                                    width: size,
                                    height: 50)
        
        revealButton.frame = CGRect(x: -10,
                                    y: locationField.bottom + 20,
                                    width: 50,
                                    height: 50)
        
        randomButton.frame = CGRect(x: 350,
                                    y: locationField.bottom + 20,
                                    width: 50,
                                    height: 50)
        
        sportText.frame = CGRect(x: -15,
                                 y: codeField.bottom + 10,
                                  width: 180,
                                  height: 50)
        
        sportPicker.frame = CGRect(x: -15,
                                   y: sportText.bottom - 10,
                                    width: 180,
                                    height: 100)
        
        participantsText.frame = CGRect(x: 180,
                                        y: codeField.bottom + 10,
                                    width: 200,
                                    height: 50)
        
        numberPicker.frame = CGRect(x: 200,
                                    y: participantsText.bottom - 10,
                                    width: 180,
                                    height: 100)
        
        datePicker.frame = CGRect(x: 0,
                                  y: sportPicker.bottom,
                                  width: 300,
                                  height: 50)
        
        privateText.frame = CGRect(x: 20,
                                   y: datePicker.bottom + 5,
                                    width: 150,
                                    height: 35)
        
        isPrivateSlider.frame = CGRect(x: 175,
                                       y: datePicker.bottom + 10,
                                       width: 150,
                                       height: 100)
        
        createEventButton.frame = CGRect(x: (view.width - 180) / 2,
                                         y: privateText.bottom + 25,
                                         width: 180,
                                         height: 60)
    }
    
    @objc func eventPicTapped() {
        presentPhotoPicker()
    }
    
    @objc private func createEventButtonTapped() {
        var eventID = ""
        Task {
            
            if (allFieldsFilled) {
                
                try await eventID = eventsm.createEvent(eventName: eventNameField.text ?? "", sport: selectedSport ?? 0, maxParticipants: selectedNumber ?? 25, description: descriptionField.text ?? "", location: locationField.text ?? "", privateEvent: isPrivateSlider.isOn, id: userAuth.currUser?.id ?? "nouid", code: codeField.text ?? "", date: datePicker.date)
                
                if pictureSelected == true {
                    guard let image = self.picView.image, let data = image.pngData() else {
                        return
                    }
                    
                    let fileName = "\(eventID)_event_picture.png"
                    
                    // upload picture
                    assert(fileName != "")
                    StorageManager.shared.uploadEventPic(with: data, fileName: fileName, completion: { result in
                        switch result {
                        case.success(let message):
                            print(message)
                        case.failure(let error):
                            print("storage manager error: \(error)")
                        }
                    })
                }
                    
                navigationController?.popViewController(animated: true)
                
                let alertController = UIAlertController(title: "Event Created", message: "Your event was successfully created!", preferredStyle: .alert)
                
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
    
    @objc private func buttonTouchDown() {
        createEventButton.backgroundColor = .darkGray
    }

    @objc private func buttonTouchUp() {
        createEventButton.backgroundColor = .sportGold
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
    
    @objc private func randomButtonTapped() {
        codeField.text = eventsm.generateRandomCode(length: 10)
    }
    
}

extension CreateEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        pictureSelected = true
        self.picView.image = selectedImage
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

#Preview {
    CreateEventViewController()
}
