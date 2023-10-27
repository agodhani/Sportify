//
//  SuggestionView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/22/23.
//


import SwiftUI
import UIKit
import MessageUI
import Firebase

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

class SuggestionPop: UIViewController {
    
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

struct SuggestionView: View {
    @State private var suggestion = "";
    @EnvironmentObject var userAuth: UserAuthentication
    @State var popUp: SuggestionPop = SuggestionPop()
//    @State var uiController: ViewController = ViewController()
    @State private var test = "";
    @State var statusText = "Input your suggestions for Sportify Improvements!"
    
    var body: some View {
        var currUser = userAuth.currUser
        var userid = currUser?.id
        
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            VStack {
                Text(statusText)
                    .foregroundColor(.white)
                    .padding()
                
                TextField("", text: $suggestion)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .frame(width: 300, height: 50)
                    .clipShape(Rectangle())
                    .textInputAutocapitalization(.never)
                
                // submit button
                Button("Submit") {
                    currUser?.newSuggestion(suggestion: suggestion)
                    let db = Firestore.firestore()
                    db.collection("Users").document(userid!).updateData(["suggestions": currUser?.suggestions])
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

