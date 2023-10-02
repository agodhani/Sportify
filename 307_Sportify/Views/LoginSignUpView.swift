//
//  LoginView.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/28/23.
//

import SwiftUI


    
struct LoginSignUpView: View {
    @EnvironmentObject var userAuth: UserAuthentication
    var body: some View {
        NavigationView {
            //aligns to the top
            //Zstack - places objects on top of one another
            //VStack - places objects in a vertical line
            //HStack - places objects on a horizontal line
            VStack() {
                //logo
                Image("SportifyLogoOriginal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
                    .padding(.vertical, -250)
                
                //Text("SPORTIFY")
                // .font(.largeTitle)
                //.bold()
                //.foregroundStyle(.white)
                //.padding(.vertical, 250)
                
                //login button
                NavigationLink(destination:LogInView().environmentObject(userAuth)) {
                    Button("LOG IN") {
                        print("Button hit!")
                        
                    }
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 50))
                }
                .padding()
                
                NavigationLink(destination:SignUpView().environmentObject(userAuth)) {
                    //signup button
                    Button("SIGN UP") {
                        
                    }
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(.gray)
                    .cornerRadius(200)
                    .offset(CGSize(width: 0, height: 125))
                }
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LoginSignUpView()
}
