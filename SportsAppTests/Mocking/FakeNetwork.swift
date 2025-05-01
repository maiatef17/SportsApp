//  NetworkMoc.swift
//  SportsAppTests
//
//  Created by Mai Atef  on 05/02/2025.
//

import Foundation
@testable import SportsApp

class MockNetworkServices: NetworkProtocol {
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let leagueFakeJsonObj: [String: Any] = [
        "result": [
            [
                "league_key": 4,
                "league_name": "UEFA Europa League",
                "country_key": 1,
                "country_name": "eurocups",
                "league_logo": "logo",
                "country_logo": "logo"
            ]
        ]
    ]
    
    let fixtureFakeJsonObj: [String: Any] = [
        "success": 1,
        "result": []
    ]
    
    let teamFakeJsonObj: [String: Any] = [
        "success": 1,
        "result": [
            [
                "teamKey": 96,
                "teamLogo": "---"
            ]
        ]
    ]
    
    enum ResponseWithError: Error {
        case responseError
    }
    
    func fetchLeagueData(sport: String, completionHandler: @escaping ([League]?) -> Void) {
        if shouldReturnError {
            completionHandler(nil)
        } else {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: leagueFakeJsonObj, options: .prettyPrinted)
                let result = try JSONDecoder().decode(LeagueResult.self, from: jsonData)
                completionHandler(result.result)
            } catch {
                completionHandler(nil)
            }
        }
    }
    
    func fetchComingData(sport: String, leagueId: Int, completionHandler: @escaping ([Fixtures]?) -> Void) {
        if shouldReturnError {
            completionHandler(nil)
        } else {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: fixtureFakeJsonObj, options: .prettyPrinted)
                let result = try JSONDecoder().decode(FixturesResult.self, from: jsonData)
                completionHandler(result.result)
            } catch {
                completionHandler(nil)
            }
        }
    }
    
    func fetchLatestData(sport: String, leagueId: Int, completionHandler: @escaping ([Fixtures]?) -> Void) {
        if shouldReturnError {
            completionHandler(nil)
        } else {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: fixtureFakeJsonObj, options: .prettyPrinted)
                let result = try JSONDecoder().decode(FixturesResult.self, from: jsonData)
                completionHandler(result.result)
            } catch {
                completionHandler(nil)
            }
        }
    }
    
    func fetchTeamsData(sport: String, leagueId: Int, completionHandler: @escaping ([Teams]?) -> Void) {
        if shouldReturnError {
            completionHandler(nil)
        } else {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: teamFakeJsonObj, options: .prettyPrinted)
                let result = try JSONDecoder().decode(TeamsResult.self, from: jsonData)
                completionHandler(result.result)
            } catch {
                completionHandler(nil)
            }
        }
    }
}
