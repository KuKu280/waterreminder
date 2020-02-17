//
//  ReminderViewController.swift
//  WaterReminder
//
//  Created by Admin on 17/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController,UNUserNotificationCenterDelegate {
    
    
    let userNotificationCenter = UNUserNotificationCenter.current()
   

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.userNotificationCenter.delegate = self
//        self.requestNotificationAuthorization()
    }
    
    
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        
        if sender.isOn{
            sendNotification()
        }
        else{
        
        }
    }
    
    func requestNotificationAuthorization() {
        // Code here
        // Auth options
           let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }

    func sendNotification() {
        // Code here
        let notificationContent = UNMutableNotificationContent()
           notificationContent.title = "Water Reminder"
           notificationContent.body = "Don't forget to drink a water!!"
           notificationContent.badge = NSNumber(value: 3)
           
        
        
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3,
                                                           repeats: false)
            let request = UNNotificationRequest(
            identifier: "WaterReminderNotification",
            content: notificationContent,
            trigger: trigger)
           
           userNotificationCenter.add(request) { (error) in
               if let error = error {
                   print("Notification Error: ", error)
               }
           }
        
    }
    
    
    
    
   
    
   
   
    
}
