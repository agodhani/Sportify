//
//  HomeView.swift
//  307_Sportify
//
//  Created by Andrew Brandon on 9/30/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
                Color.black
            
                Image("SportifyLogoOriginal")
                    .foregroundColor(.sportGold)
                    .font(.system(size: 100.0))
            }
    }
}

#Preview {
    HomeView()
}
