//
//  Teams.swift
//  SportsApp
//
//  Created by Mai Atef  on 29/01/2025.
//

import Foundation
struct TeamsResult: Codable {
    let success: Int?
    let result: [Teams]?
}

struct Teams: Codable {
   
    let team_logo: String?
    let team_name: String?
    let players: [Players]?
    let coaches: [Coaches]?

    

}
struct Players: Codable {
   
    let player_image: String?
    let player_name: String?

}
struct Coaches: Codable {
    let coach_name: String?

}


