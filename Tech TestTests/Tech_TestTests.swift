//
//  Tech_TestTests.swift
//  Tech TestTests
//
//  Created by Admin on 20.08.2024.
//

import XCTest
@testable import Tech_Test
import Combine

class MockURLSession: URLSession {
    var mockData: Data?
    var mockError: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.mockData, nil, self.mockError)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}


class Tech_TestTests: XCTestCase {
    var viewModel: PopulationDataViewModel!
    var mockSession: MockURLSession!
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        super.setUp()
        mockSession = MockURLSession()
        viewModel = PopulationDataViewModel(urlSession: mockSession)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockSession = nil
        cancellables.removeAll()
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // One example for success, for state is the same logic
    func testFetchDataNationSuccess() {
        // Prepare mock data
        let expectedNationData = PopulationNation(data: [NationData(idNation: "01000US", nation: "United States", idYear: 2022, year: "2022", population: 331097593, slugNation: "united-states")])
        mockSession.mockData = try! JSONEncoder().encode(expectedNationData)

        let expectation = XCTestExpectation(description: "Fetch nation data")

        viewModel.$nationData
            .dropFirst()
            .sink { data in
                print("Received data: \(data)")
                XCTAssertEqual(data.first, expectedNationData.data.first)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchData(populationType: .nation)

        wait(for: [expectation], timeout: 5.0)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
