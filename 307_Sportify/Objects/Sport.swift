//
//  Sport.swift
//  307_Sportify
//
//  Created by Akshay Godhani on 10/8/23.
//

import Foundation
import SwiftUI

struct Sport: Identifiable {
    var id = UUID()
    var name:String
    
    static func sportData() -> [Sport] {
        let sports: [String] = ["Tennis", "Table Tennis", "Volleyball", "Soccer", "Basketball", "Football", "Baseball", "Badminton", "Golf", "Cycling", "Running", "Hockey", "Spikeball", "Handball", "Lacrosse", "Squash"]
        return sports.map  {sport in
            Sport(name: sport)}
    }
}


