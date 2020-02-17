//
//  CupTableViewCell.swift
//  WaterReminder
//
//  Created by Admin on 20/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CupTableViewCell: UITableViewCell,CupDataDelegate {
   
    
    
    @IBOutlet weak var CupImage: UIImageView!
    @IBOutlet weak var cupLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(cups: Cups) {
            CupImage.image = UIImage(named: cups.imageName)
            cupLabel.text = cups.title
       }
    
    

}
