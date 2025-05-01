//
//  LeagueViewController 2.swift
//  SportsApp
//
//  Created by Mai Atef  on 30/01/2025.
//

protocol LeagueProtocol {
    func renderToView(res: [League])
}

import UIKit
import SDWebImage
import Kingfisher
import Reachability
class LeagueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, LeagueProtocol {
    @IBOutlet weak var leagueSearchBar: UISearchBar!
    
    @IBOutlet weak var leagueTable: UITableView!
    var presenter: Presenter!
    var leagues: [League] = []
    var sports: String?
    var filteredLeagues: [League] = []
    var isSearch = false
    let reachability = try! Reachability()
    var isConnected: Bool = false
    override func viewDidLoad() {
        navigationController?.navigationBar.tintColor = .white
        super.viewDidLoad()
        reachability.whenReachable = { reachability in
            self.isConnected = true
        }
        reachability.whenUnreachable = { reachability in
            self.isConnected = false
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        leagueTable.delegate = self
        leagueTable.dataSource = self
        leagueSearchBar.delegate = self
        ///nib
        let nib = UINib(nibName: "LeagueCell", bundle: nil)
        self.leagueTable.register(nib, forCellReuseIdentifier: "LeagueCell")
        ///presenter
        presenter = Presenter()
        presenter.attachView(view: self)
        
        if let sport = sports {
            presenter.getData(for: sport)
        }
        
    }
    func renderToView(res: [League]) {
        DispatchQueue.main.async {
            self.leagues = res
            self.leagueTable.reloadData()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ///
        if(isSearch){
            return filteredLeagues.count;

        }else{
            return  leagues.count;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        let league = isSearch ? filteredLeagues[indexPath.row] : leagues[indexPath.row]
        cell.leagueName.text = league.league_name
        
        if let imgURL = URL(string: leagues[indexPath.row].league_logo ?? "") {
            cell.leagueImage.kf.setImage(with: imgURL, placeholder: UIImage(named: "league"))
            
        }
        
       
        return cell
    }
   
        
        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detailsVC")
        as! DetailsLeagueViewController
        if isConnected{
            detailsVC.sports = self.sports
            detailsVC.leagues = isSearch ? filteredLeagues[indexPath.row] : leagues[indexPath.row]
            detailsVC.hidesBottomBarWhenPushed = true
            
            
            navigationController?.pushViewController(detailsVC, animated: true)
        }else{
            
            
            let alert = UIAlertController(title: "No Internet ", message: "please check your Internet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    ///search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearch = false
            filteredLeagues = leagues
        } else {
            isSearch = true
            filteredLeagues = leagues.filter { league in
                return league.league_name?.localizedStandardContains(searchText) ?? false
            }        }
        leagueTable.reloadData()
    }

    
    
}
