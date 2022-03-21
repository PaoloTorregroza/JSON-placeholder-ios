//
//  User.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    
    static let emptyUser = User(id: 0, name: "", username: "", email: "", phone: "", website: "")
}
