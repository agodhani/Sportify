//
//  FriendListView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 10/7/23.
//

import SwiftUI

struct FriendListView: View {
    var body: some View {
        List{
            
        }
        .navigationTitle("Friends")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Image("DefaultProfile")
            }
        }
    }
}

#Preview {
    FriendListView()
}
