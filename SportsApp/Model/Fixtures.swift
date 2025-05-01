//
//  Fixtures.swift
//  SportsApp
//
//  Created by Mai Atef  on 27/01/2025.
//

import Foundation

struct FixturesResult :Codable {
    let success:Int?
    let result:[Fixtures]?
}

    struct Fixtures: Codable {
        let event_key: Int?
        let event_date: String?
        let event_time: String?
        let event_final_result: String?
        let home_team_logo: String?
        let away_team_logo: String?
        
    
}

