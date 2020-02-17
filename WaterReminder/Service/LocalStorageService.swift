//
//  LocalStorageService.swift
//  WaterReminder
//
//  Created by Admin on 15/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class LocalStorageService {
    
    static func saveCurrentUser(user:User) {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        defaults.set(user.userId, forKey: Constants.LocalStorage.storedUserId)
        defaults.set(user.username, forKey: Constants.LocalStorage.storedUsername)
    }
    
    static func loadCurrentUser() -> User? {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        let username = defaults.value(forKey: Constants.LocalStorage.storedUsername) as? String
        let userId = defaults.value(forKey: Constants.LocalStorage.storedUserId) as? String
        
        // Couldn't get a user, return nil
        guard username != nil || userId != nil else {
            return nil
        }
        
        // Return the user
        let u = User(username: username!, userId: userId!)
        return u
    }
    
    static func clearCurrentUser() {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        defaults.set(nil, forKey: Constants.LocalStorage.storedUserId)
        defaults.set(nil, forKey: Constants.LocalStorage.storedUsername)
    }
    
}

