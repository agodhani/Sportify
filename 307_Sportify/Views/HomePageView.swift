//
//  HomePageView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        TabView {
            EventsView()
                .tabItem(){
                Image(systemName:"calendar.badge.clock")
                Text("My Events")
            }
        NotificationView()
                .tabItem(){
                Image(systemName: "bell.badge")
                Text("Notifications")
            }
        HomeView()
                .tabItem(){
                Image(systemName: "house.circle")
                Text("Home")
            }
        MessageView()
                .tabItem(){
                Image(systemName: "plus.message.fill")
                Text("Messages")
            }
        ProfileView()
                .tabItem(){
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

#Preview {
    HomePageView()
}
