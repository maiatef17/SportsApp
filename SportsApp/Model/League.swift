//
//  League.swift
//  SportsApp
//
//  Created by Mai Atef  on 27/01/2025.
//

import Foundation

struct LeagueResult: Codable {
    let success: Int?
    let result: [League]
}

struct League: Codable {
    
    var league_key: Int?
    let league_name: String?
    let league_logo: String?
    
    
}

