//
//  Cups.swift
//  WaterReminder
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Firebase

struct Cups {
    
    var imageName:String
    var title:String {
       return String(ml) + "ML"
    }
    var ml:Float
    

    init(ml:Float,imageName:String) {
        self.ml = ml
        
        self.imageName = imageName
    }
}

class WaterRecords {
    
    var DailyWaterRecord:String
    var Resultvalue:String
    var cupAmount:Float
    var totalDrinkingWater:Float
    var dateTime:String
    
    
    
    init(DailyWaterRecord:String,Resultvalue:String,cupAmount:Float,totalDrinkingWater:Float,dateTime:String) {
        self.DailyWaterRecord = DailyWaterRecord
        self.Resultvalue = Resultvalue
        self.cupAmount = cupAmount
        self.totalDrinkingWater = totalDrinkingWater
        self.dateTime = dateTime
    }
    
   

    
}
