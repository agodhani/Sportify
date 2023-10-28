//
//  MessageViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/27/23.
//

import UIKit
import SwiftUI

struct MessageViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MessageViewController
    
    func makeUIViewController(context: Context) -> MessageViewController {
        let vc = MessageViewController()
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MessageViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

class MessageViewController: UIViewController {
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SportifyLogoOriginal")
        logoView.tintColor = .yellow
        logoView.contentMode = .scaleAspectFit
        return logoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(logoView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width / 1.2
        logoView.frame = CGRect(x: (view.width - size) / 2,
                                y: 100,
                                width: size,
                                height: size)
    }
}

#Preview {
    MessageViewController()
}

