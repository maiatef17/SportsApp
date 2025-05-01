//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Mai Atef  on 29/01/2025.
//
protocol TeamsViewProtocol {
    func renderTeamsToView(resTeams: [Teams])
}

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var dataTeamTable: UITableView!
    var teamName: String?
    var teamLogo: String?
    var players: [Players] = []
    var coaches: [Coaches] = []


    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTeamTable.delegate = self
        dataTeamTable.dataSource = self
        teamTitle.text = teamName
        if let logoURL = teamLogo, let url = URL(string: logoURL) {
            teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1"))
        }
        ///nib
        let nib = UINib(nibName: "LeagueCell", bundle: nil)
        self.dataTeamTable.register(nib, forCellReuseIdentifier: "LeagueCell")
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
                case 0:
            return coaches.count

                case 1:
            return players.count

                default:
                    return 0
                }
            }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section {
            case 0:
                return "Coaches"

            case 1:
                return "Players"

            default:
                return nil
            }
        }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        switch indexPath.section {
        case 0:
            cell.leagueName.text = coaches[indexPath.row].coach_name
            cell.leagueImage.image = UIImage(named: "coach")
    case 1:
            cell.leagueName.text = players[indexPath.row].player_name
                        if let imgURL = URL(string: players[indexPath.row].player_image ?? "") {
                            cell.leagueImage.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "1"))
                        }
        

        default:
            break
                }
                
               return cell
           }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
