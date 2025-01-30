//
//  TaskTest.swift
//  TaskTest
//
//  Created by Apple on 1/25/25.
//

import XCTest
import Combine

@testable import Task

class CityViewModelTests: XCTestCase {

    var viewModel: CitiesViewModel!
    class MockDataService: DataServiceProtocol {
         func fetchCities() -> AnyPublisher<[City], Error> {
             let cities = [
                 City(country: "New South Wales", city: "Sydney"),
                 City(country: "Victoria", city: "Melbourne"),
                 City(country: "Queensland", city: "Brisbane")
             ]
             return Just(cities)
                 .setFailureType(to: Error.self)
                 .eraseToAnyPublisher()
         }
     }
    override func setUp() {
        super.setUp()
        viewModel = CitiesViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    

    func testToggleOrder() {
        let initialState = viewModel.reversed
        viewModel.reversed.toggle()

        XCTAssertNotEqual(initialState, viewModel.reversed, "Order should toggle.")
    }
}




final class TaskTest: XCTestCase {
    
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
