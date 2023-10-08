//
//  MessageView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                    
            Image(systemName: "plus.message.fill")
                .foregroundColor(.blue)
                .font(.system(size: 100.0))
        }
    }
}

#Preview {
    MessageView()
}
