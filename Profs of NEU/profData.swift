//
//  profData.swift
//  Profs of NEU
//
//  Created by Gaurav Bhambhani on 9/21/23.
//

import Foundation

struct profData: Identifiable {
    var id: String
    var name: String
    var image: String
    var about: String
    var subjects: [String]
    var comments: [String]
}
