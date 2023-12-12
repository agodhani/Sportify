//
//  TabViewController.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 11/27/23.
//

import SwiftUI

struct TabBarController: UIViewControllerRepresentable {
    @Binding var userAuth: UserAuthentication

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()

        let eventsViewController = UIHostingController(rootView: EventsViewControllerRepresentable())
        let notificationViewController = UIHostingController(rootView: NotificationViewControllerRepresentable())
        let homeEventsViewController = UIHostingController(rootView: HomeEventsViewControllerRepresentable(userAuth: userAuth))
        let messageViewController = UIHostingController(rootView: MessageViewControllerRepresentable(userAuth: userAuth))
        let profileViewController = UIHostingController(rootView: ProfileViewControllerRepresentable(userAuth: userAuth))
        
        eventsViewController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(systemName: "calendar.badge.clock"), selectedImage: nil)
               notificationViewController.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell.badge"), selectedImage: nil)
               homeEventsViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.circle"), selectedImage: nil)
               messageViewController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "plus.message.fill"), selectedImage: nil)
               profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)
        
        tabBarController.viewControllers = [
            eventsViewController,
            notificationViewController,
            homeEventsViewController,
            messageViewController,
            profileViewController
        ]

        return tabBarController
    }

    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        // Update code here if needed
    }
}


