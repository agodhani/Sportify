//
//  EventsView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct EventsView: View {
    var body: some View {
        ZStack {
                Color.black
                    
                Image(systemName: "calendar.badge.clock")
                        .foregroundColor(.green)
                        .font(.system(size: 100.0))
                }
    }
}

#Preview {
    EventsView()
}
