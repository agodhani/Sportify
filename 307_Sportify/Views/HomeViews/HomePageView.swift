//
//  HomePageView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct HomePageView: View {
    @State var userAuth = UserAuthentication()
    
    var body: some View {
        let user = userAuth.currUser
        NavigationView {
            TabView {
                EventsViewControllerRepresentable()
                    .tabItem(){
                        Image(systemName:"calendar.badge.clock")
                        Text("VC My Events")
                    }
                NotificationViewControllerRepresentable()
                    .tabItem(){
                        Image(systemName: "bell.badge")
                        Text("VC Notifications")
                    }
                HomeEventsViewControllerRepresentable(userAuth: userAuth)
                    .tabItem(){
                        Image(systemName: "house.circle")
                        Text("VC Home")
                    }
                ViewEventsListView()
                    .tabItem(){
                        Image(systemName: "house.circle")
                        Text("Home")
                    }
                MessageViewControllerRepresentable()
                    .tabItem() {
                        Image(systemName: "plus.message.fill")
                        Text("VC Messages")
                    }
                ProfileViewControllerRepresentable()
                    .tabItem() {
                        Image(systemName: "person")
                        Text("VC Profile")
                    }
                ProfileView().environmentObject(userAuth)
                    .tabItem(){
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .navigationBarBackButtonHidden(true)
            
        }
    }
}

#Preview {
    HomePageView()
}
