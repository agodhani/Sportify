//
//  UserProfileViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 11/9/23.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
    var userAuth: UserAuthentication?
    var person: Person?
    // Name label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textColor = .sportGold
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(nameLabel)
        nameLabel.text = "Name: " + (person?.name ?? "error name")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        nameLabel.frame = CGRect(x: 40,
                                 y: 200,
                                 width: size,
                                 height: 20)
    }
}
