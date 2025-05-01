//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Mai Atef  on 28/01/2025.
//

import UIKit

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueView: UIView!
    @IBOutlet weak var leagueImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leagueImage.layer.cornerRadius = leagueImage.frame.width / 2
        leagueImage.layer.borderColor = UIColor.gray.cgColor
        leagueImage.layer.borderWidth = 1
        
        leagueView.layer.cornerRadius = 10
        leagueView.layer.shadowColor = UIColor.black.cgColor
        leagueView.layer.shadowRadius = 5
        leagueView.layer.shadowOpacity = 0.2
        leagueView.layer.shadowOffset = CGSize(width: 0, height: 2)

        leagueView.layer.borderColor = UIColor.lightGray.cgColor
        leagueView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
