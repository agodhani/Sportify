//
//  FriendListView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/7/23.
//

import SwiftUI

struct FriendListView: View {
    var body: some View {
        VStack{
            Text("My Friends")
                .padding()
                .background(Color.white.opacity(0.8))
                .frame(width: 300, height: 50)
                .clipShape(Rectangle())
                .offset(CGSize(width: 0, height: 50))
            Spacer()
        }
    }
}

#Preview {
    FriendListView()
}
