//
//  _07_SportifyApp.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/28/23.
//

import SwiftUI
import FirebaseCore

//Firebase Initalization
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

// testing git again lol

@main
struct YourApp: App {
  // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    

  var body: some Scene {
      @State var userAuth = UserAuthentication()
      WindowGroup {
          NavigationView {
              if(userAuth.userSession != nil) {
                  HomePageView()
              } else {
                  LoginSignUpView()
                      .environmentObject(userAuth)
                  
              }
          }
      }
  }
}
