//
//  MockNetworkManger.swift
//  SportsAppTests
//
//  Created by Mai Atef  on 05/02/2025.
//

import XCTest
@testable import SportsApp

final class MockNetworkManger: XCTestCase {

    var mockNetworkServices: MockNetworkServices!
    var services: Services!

    override func setUpWithError() throws {
        // Initialize the mock network service and the Services class
        mockNetworkServices = MockNetworkServices(shouldReturnError: false)
        services = Services()
    }

    override func tearDownWithError() throws {
        // Clean up
        mockNetworkServices = nil
        services = nil
    }

    func testFetchLeagueData_Success() {
        let expectation = self.expectation(description: "Fetch League Data Success")
        mockNetworkServices.shouldReturnError = false

        // Act
        services.fetchLeagueData(sport: "football") { leagues in
            // Assert
            XCTAssertNotNil(leagues)
            XCTAssertEqual(leagues?.first?.league_name, "UEFA Europa League")
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test fetching league data with failure
    func testFetchLeagueData_Failure() {
        // Arrange
        let expectation = self.expectation(description: "Fetch League Data Failure")
        mockNetworkServices.shouldReturnError = true

        services.fetchLeagueData(sport: "football") { leagues in
            XCTAssertNil(leagues)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

}
