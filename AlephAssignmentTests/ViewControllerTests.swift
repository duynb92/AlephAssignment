//
//  ViewControllerTests.swift
//  AlephAssignmentTests
//
//  Created by DuyN on 7/19/18.
//  Copyright © 2018 DuyN. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import AlephAssignment

class ViewControllerTests: QuickSpec {
    override func spec() {
        describe("when ViewController is loaded") {
            var sut : ViewController!
            beforeEach {
                sut = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
                let _ = sut.view
            }
            context("collectionView") {
                it("is not nil") {
                    expect(sut.colProducts).toNot(beNil())
                }
                
                it("dataSource is set") {
                    expect(sut.colProducts.dataSource).toNot(beNil())
                    XCTAssertTrue(sut.colProducts.dataSource is ProductDataProvider)
                    
                }
                
                it("delegate is set") {
                    expect(sut.colProducts.delegate).toNot(beNil())
                    XCTAssertTrue(sut.colProducts.delegate is ProductDataProvider)
                }
                
                it("dataSource and delegate is same object") {
                    XCTAssertEqual(sut.colProducts.dataSource as? ProductDataProvider, sut.colProducts.delegate as? ProductDataProvider)
                }
            }
        }
    }
    
}
