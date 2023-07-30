//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Ekaterina Nedelko on 30.07.23.
//

import XCTest
@testable import OpenWeather

final class OpenWeatherTests: XCTestCase {
    
    private lazy var networkManager = NetworkManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let expectation = XCTestExpectation()
        networkManager.loadCurrentWeather(latitude:  Double(53.904541),
                                          longitude: Double(27.561523)) { data, error in
//            XCTAssertNotNil(error)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
