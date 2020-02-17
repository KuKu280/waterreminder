//
//  CupsViewController.swift
//  WaterReminder
//
//  Created by Admin on 15/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CupsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
   
    var cupsProduct = [Cups]()
    
    var delegate:CupDataDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)

        
    }
    
    
//    func setData(Cups: Cups) {
//
//       }
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return DataService.instance.getCupCategoris().count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CupCell", for: indexPath) as! CupsCollectionViewCell
          
          let cups = DataService.instance.getCupCategoris()[indexPath.row]
          cell.updateView(cup: cups)
          return cell
        
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        tabBarController?.selectedIndex = 1
        let cups = DataService.instance.getCupCategoris()[indexPath.row]
        
        delegate?.setData(cups: cups)
        
        
        
       
    }
   
    
   
    

    

}
