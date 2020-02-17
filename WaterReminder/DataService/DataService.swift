//
//  DataService.swift
//  WaterReminder
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService{
    static let instance  = DataService()
     private var _REF_USERS = DB_BASE.child("users")
   
   var cupsCategories = [Cups(ml: 300 , imageName: "cup1"),Cups(ml: 500 , imageName: "cup2"),Cups(ml: 600 , imageName: "cup3"),Cups(ml: 800 , imageName: "cup4"),Cups(ml: 200 , imageName: "cup5"),Cups(ml: 250 , imageName: "cup6")]
    
    var userCups = [Cups]()
    //var CupNumber = 2000
   
   func getCups() -> [Cups]{
       return userCups
   }
    
    func getCupCategoris() -> [Cups]{
        return cupsCategories
    }
    
    func addCups(newCup:Cups){
        var found = false
        for i in 0..<userCups.count {
            if userCups[i].title == newCup.title {
                userCups[i].ml += newCup.ml
                found = true
                break
            }
        }
        if (!found) {userCups.append(newCup)}
        
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
           REF_USERS.child(uid).updateChildValues(userData)
       }
    
    
    

   
}
