//
//  CupsCollectionViewCell.swift
//  WaterReminder
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CupsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cupImageView: UIImageView!
    
    @IBOutlet weak var cupLabel: UILabel!
    
    func updateView(cup:Cups){
        cupImageView.image = UIImage(named: cup.imageName)
        cupLabel.text = cup.title
        
    }
    
}
