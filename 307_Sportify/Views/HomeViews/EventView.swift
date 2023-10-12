//
//  EventView.swift
//  307_Sportify
//
//  Created by Alexandre Cunha Moraes on 10/11/23.
//

import Foundation
import SwiftUI

struct EventView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            
            // DO WE WANT AN EVENT IMAGE???
            VStack {
                VStack(alignment: .center) {
                    Text("EVENT NAME")
                        .foregroundColor(Color("SportGold"))
                        .background(.black)
                        .font(.system(size: 40, weight: .heavy, design: .default))
                    
                    Text("Event Description")
                        .foregroundColor(Color("SportGold"))
                        .background(.black)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                }
                HStack {
                    VStack {
                        Text("Event Host: name")
                            .foregroundColor(Color("SportGold"))
                            .background(.black)
                            .font(.system(size: 20, design: .default))
                        Text("Date: 12/12/2023")
                            .foregroundColor(Color("SportGold"))
                            .background(.black)
                            .font(.system(size: 20, design: .default))
                        
                    }
                    .padding(25)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    EventView()
}
