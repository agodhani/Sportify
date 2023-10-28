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
    let numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
    
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
        
        sportPicker.tag = 1
        sportPicker.delegate = self as UIPickerViewDelegate
        sportPicker.dataSource = self as UIPickerViewDataSource
        view.addSubview(sportPicker)
        sportPicker.center = self.view.center
        
        numberPicker.tag = 2
        numberPicker.delegate = self as UIPickerViewDelegate
        numberPicker.dataSource = self as UIPickerViewDataSource
        view.addSubview(numberPicker)
        numberPicker.center = self.view.center
        
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
        
        numberPicker.frame = CGRect(x: (view.width - size) / 2,
                                    y: 500,
                                    width: size,
                                    height: 100)
        

        
    }
    
    
    
    
    
}

#Preview {
    CreateEventViewController()
}
