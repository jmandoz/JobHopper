//
//  Interview.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/23/24.
//

import Foundation

struct Interview: Identifiable {
    var id = UUID().uuidString
    
    let title: String
    let desctription: String
    let time: Int?
}
