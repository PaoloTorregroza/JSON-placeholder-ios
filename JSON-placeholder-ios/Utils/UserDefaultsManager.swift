//
//  LocalPreferences.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import Foundation

struct DefaultKeys {
    static let favorites = "favorites"
}


final class UserDefaultManager {
    private static let defaults = UserDefaults.standard
    
    static func addFavorite(newFavorite: Post) {
        var current = UserDefaultManager.getFavorites()
        for post in current {
            if post.id == newFavorite.id {
                return
            }
        }
        
        current.append(newFavorite)
        
        do {
            let data = try JSONEncoder().encode(current)
            defaults.set(data, forKey: DefaultKeys.favorites)
        } catch {
          print("Error encoding user defaults")
        }
    }
    
    static func removeFavorite(exFavorite: Post) {
        var current = UserDefaultManager.getFavorites()
        guard let index = current.firstIndex(where: { el in
            return el.id == exFavorite.id
        }) else {
            return
        }
        
        current.remove(at: index)
        
        do {
            let data = try JSONEncoder().encode(current)
            defaults.set(data, forKey: DefaultKeys.favorites)
        } catch {
          print("Error encoding user defaults")
        }
    }
    
    static func getFavorites() -> [Post] {
        if let data = defaults.data(forKey: DefaultKeys.favorites) {
            do {
                return try JSONDecoder().decode(Array<Post>.self, from: data)
            } catch {}
        }
        
        return []
    }
    
    static func getSingleFavorite(id: Int) -> Post? {
        let current = UserDefaultManager.getFavorites()
        for post in current {
            if post.id == id {
                return post
            }
        }
        
        return nil
    }
    
    static func removeAllFavorites() {
        defaults.set("[]", forKey: DefaultKeys.favorites)
    }
    
    static func swapFavorite(post: Post) {
        let current = UserDefaultManager.getFavorites()
        for el in current {
            if post.id == el.id {
                UserDefaultManager.removeFavorite(exFavorite: post)
                return
            }
        }
        UserDefaultManager.addFavorite(newFavorite: post)
    }
}
