//
//  LoginViewController.swift
//  WaterReminder
//
//  Created by Admin on 17/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//


//
//  LoginViewController.swift
//  firebasedemo1
//
//  Created by Min Aung Hein on 1/4/20.
//  Copyright © 2020 Min Aung Hein. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class LoginViewController: UIViewController {
   
    
  
    
    var mode = 1 //1-Login, 0-register
    var dbref : DatabaseReference!
    var userDataRef : DatabaseReference!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var newUserBtn: UIButton!
    
   
    
    
//    @IBAction func googleLogin(_ sender: UIButton) {
//        GIDSignIn.sharedInstance().signIn()
//
//
//    }
//
//
//
//
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//          print("Back from google signIn")
//          let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
//          proceedFireBaseThirdPartyLogin(credential)
//
//      }
//
    func proceedFireBaseThirdPartyLogin(_ credential: AuthCredential ){
          Auth.auth().signIn(with: credential) { (result, error) in
              if (error == nil){
                  print(Auth.auth().currentUser?.email)
                  print(Auth.auth().currentUser?.displayName)
                  print(Auth.auth().currentUser?.photoURL)
              }
          }
      }
    
    
    func setup(){
        Utilities.styleFilledButton(loginBtn)
//        Utilities.styleFilledButton(googlesignin)
//        Utilities.styleFilledButton(applesignin)
        Utilities.styleFilledButton(newUserBtn)
        
    }
    
   
    
    override func viewDidLoad() {
           super.viewDidLoad()
            dbref = Database.database().reference()
            setup()
       
        
//            GIDSignIn.sharedInstance()?.presentingViewController = self
//            GIDSignIn.sharedInstance().delegate =  self
          // GIDSignIn.sharedInstance()?.signIn()
           // Do any additional setup after loading the view.
           //Sign Activity watcher /watchdog
        
           
        //errorLabel.alpha = 0
         
       }
    
   
    
   
    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if( auth != nil && user != nil ){
                print(user?.email,user?.displayName, user?.photoURL)
                self.performSegue(withIdentifier: "weightsegue", sender: nil)
            }
        }
    }
    
   

    @IBAction func login(_ sender: UIButton) {
        
        guard let email = username.text, email != "" else {
            return
        }
        guard let password = password.text, password != "" else {
            return
        }
        //Register
        if (mode == 0 ){
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if (error != nil){
                    print(error?.localizedDescription)
                } else {
                    
                    var userid = Auth.auth().currentUser?.uid
                    
                    self.userDataRef = self.dbref?.child("users").child(userid!)
                    
                    var userData:[String:Any] = ["DailyWaterRecord":"UserDatas"]
                    
                    self.userDataRef.setValue(userData) { (err, ref) in
                        if err != nil {
                            print(error)
                        } else {
                            self.gotoHome()
                        }
                    }
                    
                    
                    print("-->Register Success")
                    print(Auth.auth().currentUser?.email)
                     print(Auth.auth().currentUser?.uid)
                    self.gotoHome()
                }
               
                
            }
        }//Sign
        else  if (mode == 1){
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if (error != nil){
                    print(error?.localizedDescription)
                } else {
                    
                    print("-->Sign Success")
                    print(Auth.auth().currentUser?.email)
                    print(Auth.auth().currentUser?.uid)
                    self.gotoHome()
                }
            }
        }
        
    }
    
    @IBAction func changeMode(_ sender: UIButton) {
        mode = mode == 1 ? 0 : 1
        switch(mode){
        case 0: loginBtn.setTitle("Register", for: .normal)
            newUserBtn.setTitle("Already register?", for: .normal)
            
        case 1: loginBtn.setTitle("Login", for: .normal)
        newUserBtn.setTitle("New user?", for: .normal)
        default:break
        }
    }
    
    
    func gotoHome(){
        performSegue(withIdentifier: "weightsegue", sender: nil)
    }
    
   
    

}

