//
//  TabBarViewController.swift
//  WaterReminder
//
//  Created by Admin on 15/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var targetAmount:Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let homeVC = self.children[1] as! HomeViewController
        homeVC.targetAmount = self.targetAmount
        self.selectedIndex = 1
    }
    

   

}
