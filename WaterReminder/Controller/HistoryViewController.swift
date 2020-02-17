//
//  HistoryViewController.swift
//  WaterReminder
//
//  Created by Admin on 10/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase


class HistoryViewController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dbref:DatabaseReference?
    
    var waterRecords = [WaterRecords]()
    var postKey = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        dbref = Database.database().reference()
    }

    override func viewDidAppear(_ animated: Bool) {
        //readDataOnce()
        listenForData()
    }
    
//    func readDataOnce(){
//           dbref?.child("DailywaterRecord").observeSingleEvent(of: .value, with: { (snapshot:DataSnapshot) in
//
//               //Get all of the children object of the snapshot
//               let snapshots = snapshot.children.allObjects as! [DataSnapshot]
//
//               //Go through each child snapshot
//               for snap in snapshots{
//
//                   //Cast the snapshot value as a dictionary
//                   let waterDict = snap.value as! [String:Any]
//
//                   //Get the data for an WaterRecords
//                    let DailywaterRecord = snap.key
//                    let cupAmout = waterDict["cupsAmount"] as! Float
//                    let totalDrinkingWater = waterDict["totalDrinkingWater"] as! Float
//                    let result = waterDict["Resultvalue"] as! String
//                    let dateTime = waterDict["DateTime"] as! String
//
//                   //Create an waterRecords
//                    let e = WaterRecords(DailyWaterRecord: DailywaterRecord, Resultvalue: result ,cupAmount: cupAmout, totalDrinkingWater: totalDrinkingWater,dateTime: dateTime)
//
//                   //Add to the array
//                   self.waterRecords.append(e)
//               }
//               //Reload the tableView
//               self.tableView.reloadData()
//
//           })
//       }
    
    func listenForData(){
        let handle = dbref?.child("DailywaterRecord").child(Auth.auth().currentUser!.uid).observe(.value, with: { (snapshots) in
            //Get all of the children object of the snapshot
            let snapshots = snapshots.children.allObjects as! [DataSnapshot]
            
          //Clear the WaterRecords array befor parsing new waterRecords
            self.waterRecords.removeAll()
        
            //Go through each child snapshot
            for snap in snapshots{

                //Cast the snapshot value as a dictionary
                let waterDict = snap.value as! [String:Any]
                
                //Get the data for an waterRecords
                let DailywaterRecord = snap.key
                print(DailywaterRecord)
                
                let cupAmout = waterDict["cupsAmount"] as! Float
                let totalDrinkingWater = waterDict["totalDrinkingWater"] as! Float
                let result = waterDict["Resultvalue"] as! String
                let dateTime = waterDict["DateTime"] as! String
                
                //Create an waterRecords
                let e = WaterRecords(DailyWaterRecord: DailywaterRecord, Resultvalue: result,cupAmount: cupAmout, totalDrinkingWater: totalDrinkingWater,dateTime: dateTime)
                ////Add him/her to the array
                self.waterRecords.append(e)
                
                if let key = DailywaterRecord as? String {
                    self.postKey.append(key)
                }
                    
            }
            
            //Reload the tableView
            self.tableView.reloadData()
        })
    }
    
}

extension HistoryViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waterRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waterRecordCell", for: indexPath) as! HistoryTableViewCell
        let waterRecord = waterRecords[indexPath.row]
        cell.confirm(waterRecord)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == UITableViewCell.EditingStyle.delete {
               
                waterRecords.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                dbref?.child("DailywaterRecord").child(postKey[indexPath.row]).removeValue()
          
                self.tableView.reloadData()
           }
       }
    
    
    
    
}
