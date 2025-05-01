//
//  LatestCell.swift
//  SportsApp
//
//  Created by Mai Atef  on 28/01/2025.
//

import UIKit

class LatestCell: UICollectionViewCell {

    @IBOutlet weak var border: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var finalResult: UILabel!
    @IBOutlet weak var team2: UIImageView!
    @IBOutlet weak var team1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        border.layer.cornerRadius = 10
        border.layer.shadowColor = UIColor.black.cgColor
        border.layer.shadowOffset = CGSize(width: 0, height: 2)
        border.layer.shadowRadius = 4
        border.layer.shadowOpacity = 0.2
        
        border.layer.borderColor = UIColor.lightGray.cgColor
        border.layer.borderWidth = 0.5
    }

}
