//
//  WeightViewController.swift
//  WaterReminder
//
//  Created by Admin on 15/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var waterliterLabel: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var waterlitres:[String: Float] = [
        "2 liters": 2000,
        "2.7 liters":2700,
        "3 liters":3000,
        "3.67 liters":3670
    ]
    
   var waterlitresString = [String]()
    
    var weightdata:[String] = ["50kg","75kg","80kg","85kg"]
    var waterLiter:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        waterlitresString = waterlitres.map { (k, v) -> String in
            return k
        }
        
        waterlitresString.sort { $0 < $1 }
        
        waterLiter = waterlitresString.first
        setup()
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return weightdata.count
        }
        return waterlitres.count
    
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return weightdata[row]
        }
        
        return waterlitresString[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        waterliterLabel.text  = "Your daily target is \(waterlitresString[row])"
        waterLiter = waterlitresString[row]
        
    }
    
    
    
    @IBAction func NextBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "GoToTabBar", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? TabBarViewController else{ return }
        
//        waterliterLabel.text = "Your daily target is \(waterlitres)"
        destVC.targetAmount = waterlitres[waterLiter!]!
        

    }
    
    func setup(){
        Utilities.styleFilledButton(nextBtn)
    }
    
}
