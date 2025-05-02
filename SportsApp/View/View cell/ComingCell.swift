//
//  ComingCell.swift
//  SportsApp
//
//  Created by Mai Atef  on 28/01/2025.
//

import UIKit

class ComingCell: UICollectionViewCell {
    @IBOutlet weak var team1: UIImageView!
    
    @IBOutlet weak var timeEvent: UILabel!
    @IBOutlet weak var dateEvent: UILabel!
    @IBOutlet weak var Border: UIView!
   
    @IBOutlet weak var team2: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Border.layer.cornerRadius = 10
        Border.layer.shadowColor = UIColor.black.cgColor
        Border.layer.shadowOffset = CGSize(width: 0, height: 2)
        Border.layer.shadowRadius = 4
        Border.layer.shadowOpacity = 0.2
        
        Border.layer.borderColor = UIColor.lightGray.cgColor
        Border.layer.borderWidth = 0.5
        

    }

}
