//
//  SportsViewController.swift
//  SportsApp
//
//  Created by Mai Atef  on 26/01/2025.
//

import UIKit
import Reachability

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    
    let sports = [
        ("Football", "football"),
        ("Basketball", "basketball"),
        ("Tennis", "tennis"),
        ("Cricket", "cricket")
    ]
    
    let reachability = try! Reachability()
    var isConnected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        reachability.whenReachable = { reachability in
            print("Reachable")
            self.isConnected = true
        }
        reachability.whenUnreachable = { reachability in
            print("Not reachable")
            self.isConnected = false
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.sportImage.image = UIImage(named: sports[indexPath.row].1)
        cell.sportTitle.text = sports[indexPath.row].0
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        UIScreen.main.bounds.size.width/2
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 26  , height : 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagueVC = storyboard?.instantiateViewController(withIdentifier: "LeagueVC")
        as! LeagueViewController
        if isConnected {
            leagueVC.sports = sports[indexPath.row].1
            leagueVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(leagueVC, animated: true)
        } else {
            let alert = UIAlertController(title: "No Internet ", message: "please check your Internet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        
    }
}

