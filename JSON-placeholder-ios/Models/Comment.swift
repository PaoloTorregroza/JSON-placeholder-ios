//
//  Comment.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import Foundation

struct Comment: Codable, Identifiable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}

