//
//  SuggestionViewMail.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/26/23.
//

import MessageUI
import UIKit

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        view.addSubview(button)
        button.setTitle("Provide Suggestions",
                        for: .normal)
        button.backgroundColor = .sportGold
        button.setTitleColor(.black, for: .normal)
        button.center = view.center
        button.addTarget(self,
                         action: #selector(didTapButton),
                         for: .touchUpInside)
    }
    @objc private func didTapButton() {
        if MFMailComposeViewController.canSendMail(){
            let vc = MFMailComposeViewController()
            vc.delegate = self
            vc.setSubject("Sportify Suggestions")
            vc.setToRecipients(["brandoa@purdue.edu"])
            vc.setMessageBody("Hey There", isHTML: false)
            vc.setPreferredSendingEmailAddress("brandoa@purdue.edu")
            present(UINavigationController(rootViewController: vc), animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
