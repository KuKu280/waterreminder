//
//  HistoryTableViewCell.swift
//  WaterReminder
//
//  Created by Admin on 10/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    var waterRecord : WaterRecords!
    
    @IBOutlet weak var DateTimeLbl: UILabel!

    @IBOutlet weak var cupAmountLbl: UILabel!
    
    @IBOutlet weak var totalDrinkingWaterLbl: UILabel!
    
    @IBOutlet weak var ResultLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getCurrentDateTime(){
           let formatter = DateFormatter()
           formatter.dateFormat = "MM-dd-yyyy  HH:mm:a"
           let str = formatter.string(from: Date())
        DateTimeLbl.text = str
       }
    
    func confirm(_ waterRecord:WaterRecords){
        
        getCurrentDateTime()
        cupAmountLbl.text = String(waterRecord.cupAmount) + "ML"
        totalDrinkingWaterLbl.text = String(waterRecord.totalDrinkingWater) + "ML"
        ResultLbl.text = waterRecord.Resultvalue
    }

}
