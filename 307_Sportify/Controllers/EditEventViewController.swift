//
//  EditEventViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/29/23.
//

import Foundation
import UIKit

class EditEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var userid: String?
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
    var pictureSelected = false
    weak var delegate: EventUpdatedDelegate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 50)
        return scrollView
    }()
    
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
    
    private var picView: UIImageView = {
        let picView = UIImageView()
        //picView.image = UIImage(systemName: "trophy.circle")
        picView.layer.masksToBounds = true
        picView.contentMode = .scaleAspectFit
        picView.layer.borderWidth = 2
        picView.layer.borderColor = UIColor.lightGray.cgColor
        return picView
    }()
    
    private var editPicPrompt: UITextView = {
        let text = UITextView()
        text.text = "Click to edit image"
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
        datePicker.tintColor = .white
        //datePicker.backgroundColor = .clear
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
        self.hideKeyboardWhenTappedAround()
        scrollView.backgroundColor = .black
        
        eventNameField.delegate = self
        descriptionField.delegate = self
        locationField.delegate = self
        
        eventNameField.text = event?.name
        descriptionField.text = event?.description
        locationField.text = event?.location
        codeField.text = event?.code
        isPrivateSlider.setOn(event?.privateEvent ?? false, animated: true)
        selectedSport = event?.sport
        selectedNumber = event?.maxParticipants
        
        // Add subviews to view
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(editEventText)
        scrollView.addSubview(picView)
        scrollView.addSubview(editPicPrompt)
        scrollView.addSubview(eventNameField)
        scrollView.addSubview(descriptionField)
        scrollView.addSubview(locationField)
        scrollView.addSubview(codeField)
        scrollView.addSubview(numberPicker)
        scrollView.addSubview(sportText)
        sportPicker.tag = 1
        sportPicker.delegate = self as UIPickerViewDelegate
        sportPicker.dataSource = self as UIPickerViewDataSource
        scrollView.addSubview(sportPicker)
        sportPicker.center = self.view.center
        sportPicker.selectRow(event?.sport ?? 0, inComponent: 0, animated: false)
        scrollView.addSubview(participantsText)
        numberPicker.tag = 2
        numberPicker.delegate = self as UIPickerViewDelegate
        numberPicker.dataSource = self as UIPickerViewDataSource
        scrollView.addSubview(numberPicker)
        numberPicker.center = self.view.center
        numberPicker.selectRow((event!.maxParticipants - 1), inComponent: 0, animated: false)
        
        scrollView.addSubview(privateText)
        scrollView.addSubview(isPrivateSlider)
        
        // Make picture tappable
        picView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(eventPicTapped))
        picView.addGestureRecognizer(tap)
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown) // When clicked or touched down
        saveButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside) // When clicked or touched up inside
        saveButton.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside) // When clicked or touched up outside
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        scrollView.addSubview(saveButton)
        
        scrollView.addSubview(datePicker)
        
        revealButton.addTarget(self, action: #selector(revealButtonTapped), for: .touchUpInside)
        scrollView.addSubview(revealButton)
        
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        scrollView.addSubview(randomButton)
        if(userid == event?.eventHost ?? "") {
            deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            scrollView.addSubview(deleteButton)
            
        }

    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = view.width / 1.2
        backButton.frame = CGRect(x: 10, y: 60, width: 70, height: 30)
        editEventText.frame = CGRect(x: (view.width - size) / 2,
                                    y: 75,
                                    width: size,
                                    height: 52)
        picView.frame = CGRect(x: 120,
                               y: editEventText.bottom + 30,
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
                                    height: 100)
        
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
                                    height: 50)
        
        isPrivateSlider.frame = CGRect(x: 175,
                                       y: datePicker.bottom + 10,
                                       width: 150,
                                       height: 100)
        
        saveButton.frame = CGRect(x: (view.width - 180) / 2,
                                  y: privateText.bottom + 25,
                                         width: 180,
                                         height: 60)
        
        deleteButton.frame = CGRect(x: 320,
                                         y: 100,
                                         width: 60,
                                         height: 30)
    }
    
    @objc func eventPicTapped() {
        presentPhotoPicker()
    }
    
    @objc private func saveButtonTapped() {
        Task {
            if (allFieldsFilled) {
                
                if try await eventsm.modifyEvent(eventID: event?.id ?? "", eventName: eventNameField.text ?? "", date: datePicker.date, location: locationField.text ?? "", attendeeList: event?.attendeeList ?? [String](), privateEvent: isPrivateSlider.isOn, maxParticipants: selectedNumber ?? 25, adminsList: Set<User>(), eventHostID: event?.eventHost ?? "nouid", code: codeField.text ?? "", blackList: Set<User>(), requestList: event?.requestList ?? [String](), description: descriptionField.text ?? "", sport: selectedSport ?? event?.sport ?? 0) {
                    self.delegate?.eventDidUpdate()
                }
                
                if (pictureSelected == true) {
                    guard let image = self.picView.image, let data = image.pngData() else {
                        return
                    }
                    
                    let eventID = String(event?.id ?? "")
                    
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
                    
                //navigationController?.popViewController(animated: true)
                //navigationController?.topViewController =

                let alertController = UIAlertController(title: "Event Modified", message: "Your event was successfully modified!", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
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

extension EditEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    EditEventViewController()
}
