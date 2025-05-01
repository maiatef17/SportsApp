//
//  Presenter.swift
//  ProductMVC
//
//  Created by Mai Atef  on 24/01/2025.
//

import Foundation


class Presenter {
    
    let service = Services()

    ///view
     var view: LeagueProtocol?
     var viewComing: ComingViewProtocol?
     var viewLatest: LatestViewProtocol?
    var viewTeams: TeamsViewProtocol?
///

    ///attachView
    func attachView(view: LeagueProtocol) {
        self.view = view
    }
    func attachViewComing(view: ComingViewProtocol) {
        self.viewComing = view
    }
    func attachViewLatest(view: LatestViewProtocol) {
        self.viewLatest = view
    }
    func attachViewTeams(view: TeamsViewProtocol) {
        self.viewTeams = view
    }
    ////
    //////get data
    func getData(for sport: String) {
        service.fetchLeagueData(sport: sport) { [weak self] result in
            guard let self = self, let leagues = result else { return }
            self.view?.renderToView(res: leagues)
        }
    }
    func getComingFixturesData(for sport: String,leagueId: Int) {
        service.fetchComingData (sport: sport,leagueId : leagueId){ [weak self] result in
            guard let self = self, let fixtures = result else { return }
            self.viewComing?.renderComingFixturesToView(resComing: fixtures)
        }
    }
    func getLatestFixturesData(for sport: String,leagueId: Int) {
        service.fetchLatestData(sport: sport,leagueId : leagueId){ [weak self] result in
            guard let self = self, let fixtures = result else { return }
            self.viewLatest?.renderLatestFixturesToView(resLatest: fixtures)
        }
    }
    
    func getTeamsData(for sport: String,leagueId: Int) {
        service.fetchTeamsData(sport: sport,leagueId : leagueId){ [weak self] result in
            guard let self = self, let teams = result else { return }
            self.viewTeams?.renderTeamsToView(resTeams: teams)
        }
    }
}




