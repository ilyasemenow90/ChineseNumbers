//
//  NumbersTests.swift
//  NumbersTests
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import XCTest
@testable import Numbers

class NumbersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let testData: [Number] = [
            createNumber(with: "test"),
            createNumber(with: "test1")
        ]
        let storage = ContentInMemoryStorage()
        
        storage.store(data: testData)
        
        XCTAssert(storage.getAllData().count == testData.count, "Storage failed with store data")
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }
    
    func createNumber(with name: String) -> Number {
        guard let url = URL(string: "http://inu.tapptic.com/test/image.php?text=\(name)") else { fatalError() }
        
        return Number(name: name, image: url)
    }

}
