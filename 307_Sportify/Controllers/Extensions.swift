//
//  Extensions.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/18/23.
//

import Foundation
import UIKit

// Make syntax more readable
extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

// Create sport gold color
extension UIColor {
    public var sportGold: UIColor {
        return UIColor(named: "SportGold")!
    }
}

// Extension for sport picler
extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportList.count
    }
    
    private func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> String? {
        return sportList[row]
    }
}
