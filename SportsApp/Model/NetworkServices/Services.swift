//
//  Services.swift
//  SportsApp
//
//  Created by Mai Atef  on 27/01/2025.
//

import Foundation
protocol NetworkProtocol {
    func fetchLeagueData(sport: String, completionHandler: @escaping ([League]?) -> Void)
    func fetchComingData(sport: String,leagueId: Int,completionHandler: @escaping([Fixtures]?) -> Void)
    func fetchLatestData(sport: String,leagueId: Int,completionHandler: @escaping([Fixtures]?) -> Void)
    func fetchTeamsData(sport: String,leagueId: Int ,completionHandler: @escaping ([Teams]?) -> Void)

    
}

class Services: NetworkProtocol {
    
    let APIkey = "18d4af32458ed11ebd09c187e52b78fa6c469426d98c2aa3cb2609a0feec57e3"

    
    
    func fetchLeagueData(sport: String, completionHandler: @escaping ([League]?) -> Void) {
        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)?met=Leagues&APIkey=\(APIkey)") else {
            completionHandler(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completionHandler(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(LeagueResult.self, from: data)
                completionHandler(result.result)
            } catch {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    
    
    func fetchComingData(sport: String,leagueId: Int ,completionHandler: @escaping ([Fixtures]?) -> Void) {
        
        let today = Date()
           let from = today
           let to = Calendar.current.date(byAdding: .day, value: 30, to: today)!

        DateFormatter().dateFormat = "yyyy-MM-dd"

        let fromString = DateFormatter().string(from: from)
        let toString = DateFormatter().string(from: to)
        
           guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(APIkey)&leagueId=\(leagueId)&from=\(fromString)&to=\(toString)") else {
               completionHandler(nil)
               return
           }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completionHandler(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(FixturesResult.self, from: data)
                completionHandler(result.result)
            } catch {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    
    func fetchLatestData(sport: String,leagueId: Int ,completionHandler: @escaping ([Fixtures]?) -> Void) {
        
          let today = Date()
            let from = Calendar.current.date(byAdding: .day, value: -30, to: today)!
            let to = Calendar.current.date(byAdding: .day, value: -1, to: today)!

       
        DateFormatter().dateFormat = "yyyy-MM-dd"

            let fromString = DateFormatter().string(from: from)
            let toString = DateFormatter().string(from: to)

            guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(APIkey)&leagueId=\(leagueId)&from=\(fromString)&to=\(toString)") else {
                completionHandler(nil)
                return
            }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completionHandler(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(FixturesResult.self, from: data)
                completionHandler(result.result)
            } catch {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchTeamsData(sport: String,leagueId: Int ,completionHandler: @escaping ([Teams]?) -> Void) {
        
        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Teams&APIkey=\(APIkey)&leagueId=\(leagueId)") else {
            completionHandler(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completionHandler(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(TeamsResult.self, from: data)
                completionHandler(result.result)
            } catch {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
}




