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
    let event: Event = Event() // delete this once figure out

    @State var privStr: String = "Private Event"
    // private / public TODO TODO TODO
    //let eventPrivate: Bool = event.getPrivateEvent()
    /*
    if (event.getPrivateEvent()) { // TODO NEED TO FIGURE THIS OUT
        privStr = "Private Event"
    } else {
        privStr = "Public Event"
    }*/
    
    // after figure out ^^ make private = red
    //                     make public = green

    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack (alignment: .trailing) {
                
                // private / public
                Text(privStr)
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                // Event Name
                let eventName = event.eventName
                Text(eventName)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, -15)
                
                // Event Date
                let eventDate = event.date.formatted()
                // split into day (0) and time (1)
                let eventArr = eventDate.split(separator: ",", maxSplits: 2, omittingEmptySubsequences: true)
                let dateStr = String(eventArr[0] + " at" + eventArr[1])
                Text(dateStr)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                // Address / location
                // TODO
                let eventLocation = event.location // zip code ? TODO
                Text("1234 Tempo Location, Lafayette, IN 94507")
                .foregroundColor(.gray)
                .font(.system(size: 15, weight: .heavy, design: .default))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 391, height: 2)
                    .padding(1)
                
                
                // Join / leave button
                
                // Guest List
                Text("Guest List")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .heavy, design: .default))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 30)
                ScrollView {
                    
                    VStack {
                        // TODO can't figure out FOREACH
                        
                    }
                    
                }
                
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 391, height: 2)
                    .padding(1)
                
                
                
               Spacer()
            }
            
        }
        
    }
}

#Preview {
        SingleEventView()
}
