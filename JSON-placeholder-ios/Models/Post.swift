//
//  Post.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
    
    static let emptyPost = Post(id: 0, userId: 0, title: "", body: "")
}
