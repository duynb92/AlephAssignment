//
//  NetworkManagerTests.swift
//  AlephAssignmentTests
//
//  Created by DuyN on 7/18/18.
//  Copyright © 2018 DuyN. All rights reserved.
//

import XCTest
@testable import AlephAssignment

class NetworkManagerTests: XCTestCase {
    var manager: NetworkManager!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = NetworkManager.shared()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_getAndroidProducts_whenHaveNetwork() {
        var products : [Product]?
        let expectation = self.expectation(description: "test_getAndroidProducts")
        manager.getProducts(url: "ios_assignment/android.json") { pros, error in
            products = pros
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(products)
        XCTAssertTrue(products?.count == 4)
    }
    
    func test_getAppleProducts_whenHaveNetwork() {
        var products : [Product]?
        let expectation = self.expectation(description: "test_getiOSProducts")
        manager.getProducts(url: "ios_assignment/ios.json") { pros, error in
            products = pros
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(products)
        XCTAssertTrue(products?.count == 4)
    }
    
}
