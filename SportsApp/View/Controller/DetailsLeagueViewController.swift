//
//  DetailsViewController.swift
//  SportsApp
//
//  Created by Mai Atef  on 27/01/2025.
//
protocol ComingViewProtocol {
    func renderComingFixturesToView(resComing: [Fixtures])
}
protocol LatestViewProtocol {
    func renderLatestFixturesToView(resLatest: [Fixtures])
}
import UIKit
import CoreData
import Reachability
class DetailsLeagueViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,ComingViewProtocol, LatestViewProtocol ,TeamsViewProtocol{
        
    @IBOutlet weak var leagueTitle: UILabel!
    
    @IBOutlet weak var detailsColliction: UICollectionView!
    let reachability = try! Reachability()
    var isConnected: Bool = false

    

    var presenter: Presenter!
        var comingFixtures: [Fixtures] = []
          var LatestFixtures: [Fixtures] = []
    var tesms : [Teams] = []

    var sports: String?
    var leagues: League?
    override func viewDidLoad() {
        
        self.leagueTitle.text = leagues?.league_name

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
        
           let rightButton = UIBarButtonItem(image: checkAreadyFav() ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favButtonTapped))
        
           navigationItem.rightBarButtonItem = rightButton

        print("Sport: \(sports ?? " "), LeagueId: \(leagues?.league_key ?? 0)")
        detailsColliction.dataSource = self
        detailsColliction.delegate = self
        //nibs
        
        let nib = UINib(nibName: "ComingCell", bundle: nil)
        self.detailsColliction.register(nib, forCellWithReuseIdentifier: "ComingCell")
        let nib2 = UINib(nibName: "LatestCell", bundle: nil)
        self.detailsColliction.register(nib2, forCellWithReuseIdentifier: "LatestCell")
        let nib3 = UINib(nibName: "TeamsCell", bundle: nil)
        self.detailsColliction.register(nib3, forCellWithReuseIdentifier: "TeamsCell")
        let nib4 = UINib(nibName: "HeaderView", bundle: nil)
            detailsColliction.register(nib4, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        ///CollectionViewCompositionalLayout
        let layout = UICollectionViewCompositionalLayout { index, environment in
        switch index {
        case 0:
        
            return self.drawTopSection()
        case 1:
            return self.drawSecSection()
        case 2:
            return self.drawTeamsSection()
        default: return nil
        }
    }
     
    self.detailsColliction.setCollectionViewLayout(layout, animated: true)
        
        ///presenter
        presenter = Presenter()
        
        presenter.attachViewComing(view: self)
        presenter.attachViewLatest(view: self)
        presenter.attachViewTeams(view: self)
        if let sport = sports , let league = leagues {
            presenter.getComingFixturesData(for: sport, leagueId: league.league_key ?? 0)
            presenter.getLatestFixturesData(for: sport, leagueId: league.league_key ?? 0)
            presenter.getTeamsData(for: sport, leagueId: league.league_key ?? 0)
            }
           }
           
    func renderComingFixturesToView(resComing: [Fixtures]) {
        DispatchQueue.main.async {
                   self.comingFixtures = resComing
                   self.detailsColliction.reloadData()
               }
    }
   
    func renderLatestFixturesToView(resLatest: [Fixtures]) {
        DispatchQueue.main.async {
                    self.LatestFixtures = resLatest
                    self.detailsColliction.reloadData()
                }
    }
    func renderTeamsToView(resTeams: [Teams]) {
        DispatchQueue.main.async {
            self.tesms = resTeams
                    self.detailsColliction.reloadData()
                }
    }
    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            switch indexPath.section {
            case 0: 
                header.header.text = "UpComing Events"
            case 1:
                header.header.text = "Latest Results"
            case 2:
                header.header.text = "Teams"
            default: header.header.text = ""
            }
            return header
        }
        return UICollectionReusableView()
    }


    //////
    func drawTopSection()->NSCollectionLayoutSection
    {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0)
        ////
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
               let containerWidth = environment.container.contentSize.width

               items.forEach { item in
                   let distanceFromCenter = abs(item.frame.midX - offset.x - containerWidth / 2)
                   
                   let minScale: CGFloat = 0.8
            let maxScale: CGFloat = 1.0
        
        let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
                   
                   item.transform = CGAffineTransform(scaleX: scale, y: scale)
               }
           }
        // Add header to the section
           let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
           section.boundarySupplementaryItems = [header]

        return section
    }
    ///
    func drawSecSection ()->NSCollectionLayoutSection
    {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.99), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        // Add header to the section
           let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
           section.boundarySupplementaryItems = [header]
        return section
        
        
    }
    
    
    func drawTeamsSection ()->NSCollectionLayoutSection
    {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.60), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        
    /////
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                let containerWidth = environment.container.contentSize.width
                
                items.forEach { item in
                    let distanceFromCenter = abs(item.frame.midX - offset.x - containerWidth / 2.0)
                    
                    let minScale: CGFloat = 0.9
            let maxScale: CGFloat = 1.2
                let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
                    
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        // Add header to the section
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(40))
           let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
           section.boundarySupplementaryItems = [header]
        return section
        
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    

    // MARK: UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         switch section {
                case 0: return comingFixtures.count
                case 1: return LatestFixtures.count
         case 2: return tesms.count
                default: return 0
                }
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
        case  0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComingCell", for: indexPath) as! ComingCell
            cell.dateEvent.text = comingFixtures[indexPath.row].event_date
            cell.timeEvent.text = comingFixtures[indexPath.row].event_time

            if let imgURL = URL(string: comingFixtures[indexPath.row].home_team_logo ?? "") {
                cell.team1.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "1"))
                
            }
            if let imgURL = URL(string: comingFixtures[indexPath.row].away_team_logo ?? "") {
                cell.team2.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "1"))
                
            }

          

            // Configure the cell
        
            return cell
        case 1 :
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCell", for: indexPath) as! LatestCell
            cell.date.text = LatestFixtures[indexPath.row].event_date
            cell.time.text = LatestFixtures[indexPath.row].event_time
            cell.finalResult.text = LatestFixtures[indexPath.row].event_final_result


            if let imgURL = URL(string: LatestFixtures[indexPath.row].home_team_logo ?? "") {
                cell.team1.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "1"))
                
            }
            if let imgURL = URL(string: LatestFixtures[indexPath.row].away_team_logo ?? "") {
                cell.team2.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "1"))
                
            }
        
            // Configure the cell
        
            return cell
        case 2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! TeamsCell
            cell.teamName.text = tesms[indexPath.row].team_name
            if let imgURL = URL(string: tesms[indexPath.row].team_logo ?? "") {
                cell.teamImage.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "1"))
                
            }
            return cell

        default:
            return UICollectionViewCell()
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        switch indexPath.section{
            
        case 2:
            
            let teamVC = storyboard?.instantiateViewController(withIdentifier: "teamVC")
            as! TeamDetailsViewController
            if isConnected {
                
                teamVC.teamName = tesms[indexPath.row].team_name
                teamVC.teamLogo = tesms[indexPath.row].team_logo
                teamVC.players = tesms[indexPath.row].players ?? []
                teamVC.coaches=tesms[indexPath.row].coaches ?? []
                teamVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(teamVC, animated: true)
            }else{
                let alert = UIAlertController(title: "No Internet ", message: "please check your Internet", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
            }
        default:
            return

        }
        

    }
    //favv
    @objc func favButtonTapped() {
        guard let league = leagues else { return }
        
        //1-view context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manger = appDelegate.persistentContainer.viewContext
        
        
        if checkAreadyFav() {
            let alert = UIAlertController(title: "Favorites", message: "\(league.league_name!) is already in favorites", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            //2
            let entity = NSEntityDescription.insertNewObject(forEntityName: "FavoriteLeague", into: manger)
            //set
            entity.setValue(league.league_key, forKey: "leagueKey")
            entity.setValue(league.league_name, forKey: "leagueName")
            entity.setValue(league.league_logo, forKey: "leagueLogo")
            entity.setValue(self.sports, forKey: "sportName")
            
            //save 
            do{
                try manger.save()
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
                let alert = UIAlertController(title: "Favorites", message:"\( league.league_name!) saved to favourits", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                
            } catch {
                print(error.localizedDescription)
            }
        }}
    
    
    
    //fetch and check
    func checkAreadyFav() -> Bool {
        guard let league = leagues else { return false }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manger = appDelegate.persistentContainer.viewContext

    let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        
        
        fetch.predicate = NSPredicate(format: "leagueKey == %d", league.league_key ?? 0)

        do {
            let sameId = try manger.fetch(fetch)
            return !sameId.isEmpty
        } catch let error {
            print(error.localizedDescription)
            return false
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
