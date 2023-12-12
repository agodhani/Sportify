//
//  LoginView.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 9/28/23.
//

import SwiftUI

struct TestViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = LoginSignUpViewController
    
    func makeUIViewController(context: Context) -> LoginSignUpViewController {
        let vc = LoginSignUpViewController()
        // Do some configurations here if needed.
        return vc
    }
    
    func updateUIViewController(_ uiViewController: LoginSignUpViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
    
struct LoginSignUpView: View {
    @EnvironmentObject var userAuth: UserAuthentication
    @State private var showSignUp = false;
    @State private var showLogIn = false;

    var body: some View {
    
        NavigationView {
            //aligns to the top
            //Zstack - places objects on top of one another
            //VStack - places objects in a vertical line
            //HStack - places objects on a horizontal line
            ZStack() {
                //logo
                Color.black.ignoresSafeArea()
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
                //NavigationLink(destination:LogInView().environmentObject(userAuth)) {
                Button("LOG IN") {
                    print("Button hit!")
                    showLogIn = true
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(Color("SportGold"))
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 50))
                
                //}
                //.padding()
                
                //NavigationLink(destination:SignUpView().environmentObject(userAuth)) {
                //signup button
                
                Button("SIGN UP") {
                    showSignUp = true
                    
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .frame(width: 225, height: 50)
                .background(.gray)
                .cornerRadius(200)
                .offset(CGSize(width: 0, height: 125))
                //}
                if(showLogIn) {
                    LogInView().environmentObject(userAuth)
                }
                if(showSignUp) {
                    SignUpView().environmentObject(userAuth)
                }
                
            }
        }
            .navigationBarBackButtonHidden(true)
        //}
    }
}

#Preview {
    LoginSignUpView()
}
