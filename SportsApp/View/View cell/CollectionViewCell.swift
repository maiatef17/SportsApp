//
//  CollectionViewCell.swift
//  SportsApp
//
//  Created by Mai Atef  on 27/01/2025.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
        
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }
}


