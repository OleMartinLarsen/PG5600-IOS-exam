//
//  RoundedButton.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 28/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit

class roundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.yellow.cgColor
    }
    
}
