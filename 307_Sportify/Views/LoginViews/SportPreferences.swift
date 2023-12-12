//
//  SportPreferences.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/9/23.
//

import SwiftUI

struct MultiSelectRow: View {
    var sport:Sport
    @Binding var selectedItems: Set<UUID>
    var isSelected: Bool {
        selectedItems.contains(sport.id)
    }
    var body: some View {
        HStack {
            Text(self.sport.name)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            if(self.isSelected) {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.blue)
            }
        }.onTapGesture {
            if self.isSelected {
                self.selectedItems.remove(self.sport.id)
            } else {
                self.selectedItems.insert(self.sport.id)
            }
        }.contentShape(Rectangle())
    }
}
struct SportPreferences: View {
    @State private var sports = Sport.sportData()
    @Binding var selectedSports: Set<UUID>
    @State private var buttonTapped = false
    var body: some View {
        NavigationView {
            VStack {
                if(buttonTapped) {
                    SignUpView()
                }
                List(sports, selection: $selectedSports) { sport in
                    MultiSelectRow(sport:sport, selectedItems: $selectedSports)
                } .navigationTitle(Text("Selected \(selectedSports.count) sports"))
                Button("Done") {
                    buttonTapped = true
                }
                .frame(width:200, height: 50)
                .background(Color("SportGold"))
                
            }
            
        }
    }
}

