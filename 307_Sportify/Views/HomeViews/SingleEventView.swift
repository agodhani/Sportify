//
//  SingleEventView.swift
//  307_Sportify
//
//  Created by Joshua Tseng on 10/10/23.
//

import SwiftUI

struct SingleEventView: View {
    @State var userAuth = UserAuthentication()
    // EVENT TODO how to get from outside

    var body: some View {

        let event: Event = Event() // delete this
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack (alignment: .leading) {
                
                // private / public
                let eventPrivate = event.privateEvent
                var privStr: String = ""
                if (eventPrivate) {
                    let privStr = "Private Event"
                } else {
                    let privStr = "Public Event"
                }
                Text(privStr)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .heavy, design: .default))
                
            }
            
        }
        
    }
}

#Preview {
        SingleEventView()
}
