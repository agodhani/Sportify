//
//  NotificationView.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/27/23.
//

import UIKit
import SwiftUI

struct NotificationViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = NotificationViewController
    
    func makeUIViewController(context: Context) -> NotificationViewController {
        let vc = NotificationViewController()
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: NotificationViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

class NotificationViewController: UIViewController {
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "DefaultProfile")
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
    NotificationViewController()
}
