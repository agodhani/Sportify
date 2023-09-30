//
//  ProfileView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.black
                    
            Image(systemName: "person")
                .foregroundColor(.gray)
                .font(.system(size: 100.0))
        }
    }
}

#Preview {
    ProfileView()
}
