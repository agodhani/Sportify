//
//  ProfileView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//
//This is just a rough draft, I realized later that I could
//  set locations of things, but for now just created
//  spaces with Hstack, but will change in future 10/4

import SwiftUI
import Firebase

class profileControl:UIViewController {
    
}

struct ProfileView: View{
    @EnvironmentObject var userAuth: UserAuthentication
    @State private var sOut = false;
    @State private var pView = false;
    @State private var friendsView = false;
    @State private var myFriends = false;
    @State private var blockView = false;
    @State private var suggestion = false;
    let db = Firestore.firestore()
   
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            let user = userAuth.currUser
            VStack {
                HStack {
                    Spacer()
                    Image("DefaultProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .cornerRadius(200)
                        .clipShape(Circle())
                        .padding()
                    Spacer()
                }
                if(user != nil) {
                    HStack{
                        Text("Name:")
                            .foregroundColor(Color("SportGold"))
                        Text(user!.name)
                            .foregroundColor(Color("SportGold"))
                        
                        Spacer()
                    }
                }
                HStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                /*  if (user != nil){
                 HStack{
                 Text("Username:")
                 .foregroundColor(Color("SportGold"))
                 Text(user.fullName)
                 .foregroundColor(Color("SportGold"))
                 Spacer()
                 }
                 }*/
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                if (user != nil){
                    HStack{
                        Text("Location:")
                            .foregroundColor(Color("SportGold"))
                        Text(user?.zipCode ?? "")
                            .foregroundColor(Color("SportGold"))
                        Spacer()
                    }
                }
                
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Text("Sport Preferences:")
                        .foregroundColor(Color("SportGold"))
                    Text("Football, Dodgeball, Basketball")
                        .foregroundColor(Color("SportGold"))
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                Button("Edit Profile"){
                    pView = true
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                HStack{
                    Spacer()
                }
                
                
                //NavigationLink(destination:EditProfileView()){
                Button("Sign Out"){
                    userAuth.signOut()
                    sOut = true;
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .foregroundColor(.red)
                .cornerRadius(200)
                //}
                Spacer()
                HStack{
                    Button("Add Friends"){
                        friendsView = true
                    }
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 100, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    
                    Spacer()
                    
                    Button("Block Users"){
                        blockView = true;
                    }
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 100, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    
                    Spacer()
                    
                    
                    Button("My Friends"){
                        myFriends = true;
                    }
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 100, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    
                    Spacer()
                    Button("Suggestion"){
                        suggestion = true;
                    }
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 100, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                }
                
            }
            if(sOut) {
                NavigationView {
                    LoginSignUpView()
                }
            }
            if(pView) {
                NavigationView {
                    EditProfileView()
                }
            }
            if(friendsView) {
                NavigationView {
                    FriendListView(locationFilter: false)
                }
            }
            if (myFriends) {
                NavigationView {
                    MyFriends()
                }
            }
            if (blockView) {
                NavigationView {
                    BlockView()
                }
            }
            if (suggestion) {
                NavigationView {
                    SuggestionView()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
