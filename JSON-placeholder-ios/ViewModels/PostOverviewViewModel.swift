//
//  PostOverviewViewModel.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import Foundation
import Alamofire
import SwiftUI

class PostOverviewViewModel: ObservableObject {
    @Published var user: User = User.emptyUser
    @Published var comments: Array<Comment> = []
    @Published var isFavorite = false
    var post: Post
    
    init(post: Post) {
        self.post = post
        checkFavorite()
    }
    
    func getUserInfo() {
        let request = AF.request(JSONPlaceholderMappings.users+"/\(post.userId)", encoding: JSONEncoding.default)
        request.responseDecodable(of: User.self) { response in
            switch response.result {
            case .failure:
                print(response.error ?? "")
                
            case .success:
                guard let data = response.value else {return}
                self.user = data
            }
        }
    }
    
    func getPostComments() {
        let request = AF.request(JSONPlaceholderMappings.comments + "?postId=\(post.id)", encoding: JSONEncoding.default)
        request.responseDecodable(of: Array<Comment>.self) { response in
            switch response.result {
            case .failure:
                print(response.error ?? "")
            case .success:
                guard let data = response.value else {return}
                self.comments = data
            }
        }
    }
    
    func swapFavorite() {
        isFavorite = !isFavorite
        if (isFavorite) {
            UserDefaultManager.addFavorite(newFavorite: post)
        }
        else {
            UserDefaultManager.removeFavorite(exFavorite: post)
        }
    }
    
    func checkFavorite() {
        let favorite = UserDefaultManager.getSingleFavorite(id: post.id)
        if (favorite != nil) {
            isFavorite = true
        } else {
            isFavorite = false
        }
    }
}
