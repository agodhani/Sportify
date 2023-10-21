//
//  SignUpViewController.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/21/23.
//

import UIKit

class SignUpViewController: UIViewController {

    // Might be too long to fit, use a scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    // Logo
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SportifyLogoOriginal")
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    // Email txt field
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Email Address"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        return field
    }()
    
    // Name txt field
    private let nameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.placeholder = "Full Name"
        field.backgroundColor = .lightGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .lightGray
        return field
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
        
        // Add subviews to view
        view.addSubview(scrollView)
        scrollView.addSubview(logoView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(nameField)
        scrollView.addSubview(signupButton)
    }
    
    // Organize view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 1.3
        logoView.frame = CGRect(x: (scrollView.width - size) / 2,
                                y: 10,
                                width: size,
                                height: size)
        emailField.frame = CGRect(x: 45,
                                  y: logoView.bottom - 50,
                                  width: size,
                                  height: 50)
        nameField.frame = CGRect(x: 45,
                                  y: emailField.bottom + 15,
                                  width: size,
                                  height: 50)
        signupButton.frame = CGRect(x: 90,
                                    y: logoView.bottom + 205,
                                    width: 225,
                                    height: 50)
    }
    
    @objc private func tappedLogIn() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

#Preview {
    SignUpViewController()
}
