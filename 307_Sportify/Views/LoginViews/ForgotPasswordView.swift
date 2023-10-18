//
//  ForgotPasswordView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 9/29/23.
//

import SwiftUI
import UIKit

//class ViewController: UIViewController {
//    
//    @IBAction func buttonAction(_ sender: UIButton) {
//        let overLayer = OverLayerPopUp()
//        overLayer.appear(sender: self)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}

class OverLayerPopUp: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBAction func doneAction(_sender: UIButton) {
        hide()
    }
     
    
    init() {
        super.init(nibName: "OverLayerPopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implmented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false)
        self.show()
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
}

struct ForgotPasswordView: View {
    
    
    @State private var email = "";
    @EnvironmentObject var userAuth: UserAuthentication
    @State var popUp: OverLayerPopUp = OverLayerPopUp()
//    @State var uiController: ViewController = ViewController()
    @State private var test = "";
    @State var statusText = "Input your associated account email"
    
    var body: some View {
        
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack {
                Text(statusText)
                    .foregroundColor(.white)
                    .padding()
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                
                // submit button
                Button("Submit") {
                    
                    action: do {
                        
                        Task {
                            //popUp.appear(sender: uiController)
                            do {
                                try await userAuth.forgotPasswordEmail(email: email)
                                statusText = "Email sent! Check your inbox for email"
                            } catch {
                                statusText = "Provided email was not found"
                            }
                        }
                    }
                }
                .foregroundColor(.black)
                .fontWeight(.heavy)
                    .frame(width: 225, height: 50)
                    .background(Color("SportGold"))
                    .cornerRadius(200)
                    .padding()
            }
            .offset(CGSize(width: 0, height: -20))
        }
    }
}

#Preview {
    ForgotPasswordView()
}
