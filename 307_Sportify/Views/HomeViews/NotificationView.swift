//
//  NotificationView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                    
            Image(systemName: "bell.badge")
                .foregroundColor(.yellow)
                .font(.system(size: 100.0))
            }
    }
}

#Preview {
    NotificationView()
}
