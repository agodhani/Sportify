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
            
            VStack (alignment: .trailing) {
                
                // private / public TODO TODO TODO
                let eventPrivate = event.privateEvent
                var privStr: String = ""
                if (eventPrivate) {
                    let privStr = "Private Event"
                } else {
                    let privStr = "Public Event"
                }
                Text(privStr)
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .heavy, design: .default))
                
                // Event Name
                let eventName = event.eventName
                Text(eventName)
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .heavy, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                // Event Date
                let eventDate = event.date.formatted()
                // split into day (0) and time (1)
                let eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
                let dateStr = String(eventArr[0] + " at" + eventArr[1])
                Text(dateStr)
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                
                
               Spacer()
            }
            
        }
        
    }
}

#Preview {
        SingleEventView()
}
