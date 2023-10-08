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
                ProfileView().environmentObject(userAuth)
                    .tabItem(){
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomePageView()
}
