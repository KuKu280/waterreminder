//
//  HomeViewController.swift
//  WaterReminder
//
//  Created by Admin on 15/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn


class HomeViewController: UIViewController,CupDataDelegate, UITableViewDelegate,UITableViewDataSource{
   
    var dbref:DatabaseReference!
    var userid = Auth.auth().currentUser?.uid
    
    var targetAmount:Float = 0.0
    var cupsProduct = [Cups]()
    var userCups = [Cups]()
    var totalDrinkingWater:Float = 0.0
    var cupAmount:Float = 0.0
    
    var waterRecords = [WaterRecords]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var dailyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logout: UIButton!
    
    
   
    var delegate:CupDataDelegate?
    let progress = Progress(totalUnitCount: 10)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = self.tabBarController
        let cupVC = tabbar?.viewControllers?[2]  as! CupsViewController
        cupVC.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        progressView.setProgress(0, animated: false)
        
        dailyLabel.text = "Your dailty target amount is:\(targetAmount)ml "
        
        dbref = Database.database().reference().child("DailywaterRecord")
        setup()
        
        
    }
    
    func readData() {
        let handle = dbref.observe(.value) { (snapshot) in
            let snapshot = snapshot.children.allObjects as![DataSnapshot]
            
            for snap in snapshot {
              
                
                
            }
        }
    }
    
    func setData(cups: Cups) {
        DataService.instance.addCups(newCup: cups)
        tableView.reloadData()
        
    }
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCups().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CupCell", for: indexPath) as! CupTableViewCell
        let cups = DataService.instance.getCups()[indexPath.row]
        
        cell.setData(cups: cups)
        
    
       return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            DataService.instance.userCups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cupAmount = DataService.instance.userCups[indexPath.row].ml
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        
        totalDrinkingWater += cupAmount
        progressView.progress = totalDrinkingWater / targetAmount
        self.titleLabel.text = "\(String(format:"%.0f",(totalDrinkingWater / targetAmount)*100))%"
        
//        let key = dbref.childByAutoId().key
        let recordData:[String:Any] = [
            "cupsAmount":cupAmount,
            "totalDrinkingWater":totalDrinkingWater,
            "Resultvalue":titleLabel.text!,
            "DateTime":"\(Date())"
        ]
        dbref.child(userid!).childByAutoId().setValue(recordData)
        

//       dbref.childByAutoId().setValue(recordData)
        
    }
    
    
    @IBAction func signOut(_ sender: UIButton) {
    
    do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance()?.signOut()
        self.tabBarController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
              
           }catch let error {
               print(error.localizedDescription)
           }
           
       }
    
    func setup(){
        Utilities.styleFilledButton(logout)
    }
        
            

}

