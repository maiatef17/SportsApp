//
//  FavViewController.swift
//  SportsApp
//
//  Created by Mai Atef  on 27/01/2025.
//

import UIKit
import CoreData
import SDWebImage
import Reachability
class FavViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
   
    let reachability = try! Reachability()
    var isConnected: Bool = false

    @IBOutlet weak var favTable: UITableView!
    var favoriteLeagues: [NSManagedObject] = []
    var sports: String?
    var presenter: Presenter!

    override func viewDidLoad() {
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
        
    
        navigationController?.navigationBar.tintColor = .white

        favTable.delegate = self
            favTable.dataSource = self
        
        ///nib
        let nib = UINib(nibName: "LeagueCell", bundle: nil)
        self.favTable.register(nib, forCellReuseIdentifier: "LeagueCell")
        presenter = Presenter()

        if let sport = sports {
            presenter.getData(for: sport)
        }
        fetchFavorites()
        favTable.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }

    
    //fetch DB
    func fetchFavorites() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manger = appDelegate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")

        do {
            favoriteLeagues = try manger.fetch(fetch)
            DispatchQueue.main.async {
                self.favTable.reloadData()
            }
        
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        let league =  favoriteLeagues[indexPath.row]
        cell.leagueName.text = league.value(forKey: "leagueName") as? String
         
        if let imgURL = league.value(forKey: "leagueLogo") as? String, let url = URL(string: imgURL) {
            cell.leagueImage.sd_setImage(with: url, placeholderImage: UIImage(named: "league"))
            }
    
        
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsLeagueViewController
        if isConnected {
            
            detailsVC.leagues = League(
                league_key: favoriteLeagues[indexPath.row].value(forKey: "leagueKey") as? Int,
                league_name: favoriteLeagues[indexPath.row].value(forKey: "leagueName") as? String,
                league_logo: favoriteLeagues[indexPath.row].value(forKey: "leagueLogo") as? String
            )
            
            detailsVC.sports = favoriteLeagues[indexPath.row].value(forKey: "sportName") as? String
            
            navigationController?.pushViewController(detailsVC, animated: true)
        }else{
            
            let alert = UIAlertController(title: "No Internet ", message: "please check your Internet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //delete
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete ", message: "are you sure you want to delete league from favorites ?", preferredStyle: .alert)
            //delete
            let deleteAction = UIAlertAction(title:"Delete", style: .destructive) { _ in
                let leagueDelete = self.favoriteLeagues[indexPath.row]

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manger = appDelegate.persistentContainer.viewContext

            manger.delete(leagueDelete)

                do {
                    try manger.save()
                    //reload
                    self.favoriteLeagues.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            //cancel
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            //add both
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
          self.present(alert, animated: true)
        }
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
