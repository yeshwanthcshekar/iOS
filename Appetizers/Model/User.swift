//
//  User.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/11/25.
//

import Foundation

struct User: Codable {
    var firstName       = ""
    var lastName        = ""
    var email           = ""
    var birthdate       = Date()
    var extraNapkins    = false
    var frequentRefills = false
}
