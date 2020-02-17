//
//  AppDelegate.swift
//  WaterReminder
//
//  Created by Admin on 15/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import GoogleSignIn
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert,.sound]) { (authorized:Bool, error:Error?) in
            if !authorized{
                print("Notification")
            }
        }
        FirebaseApp.configure()
        
        Database.database().isPersistenceEnabled = true
                
//        //Google Login Setup
//        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        IQKeyboardManager.shared.enable = true
        
        
        
        
    
        return true
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        

        let ableGoogle =  GIDSignIn.sharedInstance().handle(url)
        return  ableGoogle
    }
    
    
    
   
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
   
    
   


}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("I got noti")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Will present got notification")
        print(notification.date, notification.request.content.title, notification.request.content.body)
        completionHandler([.alert, .sound])
    }
    
}
