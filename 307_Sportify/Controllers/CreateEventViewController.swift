//
//  CreateEventViewController.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/28/23.
//

import Foundation
import UIKit

class CreateEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let sportList = Sport.sportData()
    
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
        text.text = "Sport:"
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
    
    private var sportPicker: UIPickerView = {
        let picker = UIPickerView()
        //picker.backgroundColor = .gray
        return picker
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = sportList[row].name
        return item
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: sportList[row].name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.sportGold])
    }
    
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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Add subviews to view
        view.addSubview(newEventText)
        view.addSubview(eventNameField)
        view.addSubview(descriptionField)
        view.addSubview(locationField)
        
        view.addSubview(sportText)
        sportPicker.delegate = self as UIPickerViewDelegate
        sportPicker.dataSource = self as UIPickerViewDataSource
        view.addSubview(sportPicker)
        sportPicker.center = self.view.center
        
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
        
        sportText.frame = CGRect(x: (view.width - size) / 2,
                                  y: 380,
                                  width: size,
                                  height: 50)
        
        sportPicker.frame = CGRect(x: (view.width - size) / 2,
                                    y: 420,
                                    width: size,
                                    height: 100)
        

        
    }
    
    
    
    
    
}

#Preview {
    CreateEventViewController()
}
