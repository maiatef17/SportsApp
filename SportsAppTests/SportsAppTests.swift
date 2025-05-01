//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by Mai Atef  on 27/01/2025.
//

import XCTest
@testable import SportsApp

final class SportsAppTests: XCTestCase {
    var services: Services!
       var mockNetworkServices: MockNetworkServices!

       override func setUpWithError() throws {
           try super.setUpWithError()
           services = Services()
           mockNetworkServices = MockNetworkServices(shouldReturnError: false)
       }

       override func tearDownWithError() throws {
           services = nil
           mockNetworkServices = nil
           try super.tearDownWithError()
       }
    
    
    
    func testFetchLeagueData_Success() {
        // Arrange
        let expectation = self.expectation(description: "Fetch League Data Success")
        mockNetworkServices.shouldReturnError = false

        // Act
        services.fetchLeagueData(sport: "football") { leagues in
            // Assert
            XCTAssertNotNil(leagues)
            XCTAssertEqual(leagues?.count, 1)
            XCTAssertEqual(leagues?.first?.league_name, "UEFA Europa League")
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchLeagueData_Failure() {
        // Arrange
        let expectation = self.expectation(description: "Fetch League Data Failure")
        mockNetworkServices.shouldReturnError = true

        // Act
        services.fetchLeagueData(sport: "football") { leagues in
            // Assert
            XCTAssertNil(leagues)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchComingData_Success() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Coming Data Success")
        mockNetworkServices.shouldReturnError = false

        // Act
        services.fetchComingData(sport: "football", leagueId: 123) { fixtures in
            // Assert
            XCTAssertNotNil(fixtures)
            XCTAssertEqual(fixtures?.count, 0) // Assuming the fake JSON returns an empty array
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchComingData_Failure() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Coming Data Failure")
        mockNetworkServices.shouldReturnError = true

        // Act
        services.fetchComingData(sport: "football", leagueId: 123) { fixtures in
            // Assert
            XCTAssertNil(fixtures)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchLatestData_Success() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Latest Data Success")
        mockNetworkServices.shouldReturnError = false

        // Act
        services.fetchLatestData(sport: "football", leagueId: 123) { fixtures in
            // Assert
            XCTAssertNotNil(fixtures)
            XCTAssertEqual(fixtures?.count, 0) // Assuming the fake JSON returns an empty array
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchLatestData_Failure() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Latest Data Failure")
        mockNetworkServices.shouldReturnError = true

        // Act
        services.fetchLatestData(sport: "football", leagueId: 123) { fixtures in
            // Assert
            XCTAssertNil(fixtures)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testFetchTeamsData_Success() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Teams Data Success")
        mockNetworkServices.shouldReturnError = false

        // Act
        services.fetchTeamsData(sport: "football", leagueId: 123) { teams in
            // Assert
            XCTAssertNotNil(teams)
            XCTAssertEqual(teams?.count, 1)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchTeamsData_Failure() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Teams Data Failure")
        mockNetworkServices.shouldReturnError = true

        // Act
        services.fetchTeamsData(sport: "football", leagueId: 123) { teams in
            // Assert
            XCTAssertNil(teams)
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
   }
