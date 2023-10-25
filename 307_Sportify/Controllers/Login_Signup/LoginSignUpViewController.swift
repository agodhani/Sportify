//
//  LoginSignUpViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/18/23.
//

import UIKit
import SwiftUI

class LoginSignUpViewController: UIViewController {
    
    // Logo
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SportifyLogoOriginal")
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    // Login button
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG IN", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    // Sign up button
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        signupButton.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        
        // Add subviews to view
        view.addSubview(logoView)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        logoView.frame = CGRect(x: (view.width - size) / 2,
                                y: 100,
                                width: size,
                                height: size)
        loginButton.frame = CGRect(x: 90,
                                   y: logoView.bottom - 20,
                                  width: 225,
                                  height: 50)
        signupButton.frame = CGRect(x: 90,
                                   y: logoView.bottom + 65,
                                  width: 225,
                                  height: 50)
    }
    
    @objc private func tappedSignUp() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

#Preview {
    LoginSignUpViewController()
}
