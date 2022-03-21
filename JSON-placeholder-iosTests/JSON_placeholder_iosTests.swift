//
//  JSON_placeholder_iosTests.swift
//  JSON-placeholder-iosTests
//
//  Created by Paolo on 20/03/22.
//

import XCTest
@testable import JSON_placeholder_ios

class JSON_placeholder_iosTests: XCTestCase {
    private var userDefaults: UserDefaults!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSavesToUserDefault() throws {
        UserDefaultManager.addFavorite(newFavorite: Post(id: 1, userId: 12, title: "Test", body: "Body"))
        UserDefaultManager.addFavorite(newFavorite: Post(id: 123, userId: 121, title: "Test 2", body: "Body 2"))
        
        let saved = UserDefaultManager.getSingleFavorite(id: 123)
        XCTAssert(saved != nil)
    }
    
    func testClearPostsUserDefault() throws {
        UserDefaultManager.addFavorite(newFavorite: Post(id: 1, userId: 12, title: "Test", body: "Body"))
        UserDefaultManager.addFavorite(newFavorite: Post(id: 123, userId: 121, title: "Test 2", body: "Body 2"))
        
        UserDefaultManager.removeAllFavorites()
        XCTAssert(UserDefaultManager.getFavorites().isEmpty)
    }
    
    func testRemoveSingleFavorite() throws {
        UserDefaultManager.addFavorite(newFavorite: Post(id: 1, userId: 12, title: "Test", body: "Body"))
        UserDefaultManager.addFavorite(newFavorite: Post(id: 123, userId: 121, title: "Test 2", body: "Body 2"))
        
        UserDefaultManager.removeFavorite(exFavorite: UserDefaultManager.getSingleFavorite(id: 123)!)
        
        let saved = UserDefaultManager.getSingleFavorite(id: 123)
        
        XCTAssert(saved == nil)
    }
}
