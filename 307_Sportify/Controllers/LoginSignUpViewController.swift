//
//  LoginSignUpViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/18/23.
//

import UIKit
import SwiftUI

class LoginSignUpViewController: UIViewController {
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SportifyLogoOriginal")
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    // TODO: sign up button

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Add subviews
        view.addSubview(logoView)
        view.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        logoView.frame = CGRect(x: (view.width - size) / 2,
                                y: 100,
                                width: size,
                                height: size)
        loginButton.frame = CGRect(x: (view.width - size) / 2,
                                   y: logoView.bottom - 20,
                                  width: 225,
                                  height: 50)
    }

}

#Preview {
    LoginSignUpViewController()
}
