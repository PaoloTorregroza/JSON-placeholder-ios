//
//  HomeViewModel.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import Foundation
import Alamofire
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var posts: Array<Post> = []
    @Published var onlyFavorites = false
    
    func getPosts() {
        let request = AF.request(JSONPlaceholderMappings.posts, encoding: JSONEncoding.default)
        request.responseDecodable(of: Array<Post>.self) { response in
            switch response.result {
            case .failure:
                print(response.error ?? "")
                
            case .success:
                guard let data = response.value else {return}
                self.sortPosts(newPosts: data)
            }
        }
    }
    
    func removePost(id: Int) {
        guard let index = posts.firstIndex(where: { el in
            return el.id == id
        }) else {
            return
        }
        
        posts.remove(at: index)
    }
    
    func sortPosts(newPosts: [Post]) {
        posts = newPosts.sorted { a, b in
            let aFavorite = UserDefaultManager.getSingleFavorite(id: a.id) != nil
            let bFavorite = UserDefaultManager.getSingleFavorite(id: b.id) != nil
            return aFavorite && !bFavorite
        }
    }
}
