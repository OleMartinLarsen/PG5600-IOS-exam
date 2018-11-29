//
//  CharacterCollectionViewCell.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 26/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func drawColor() {
        imageView.backgroundColor = UIColor.orange
    }
}
