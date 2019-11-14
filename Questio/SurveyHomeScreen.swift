//
//  ViewController.swift
//  Questio
//
//  Created by Rahul Berry on 31/10/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit

import Firebase

class SurveyHomeScreen: UIViewController {
    
    @IBOutlet weak var Animoji: UIImageView!
    @IBOutlet weak var SurveyButtonOutlet: UIButton!
    
    var uid = ""
    var faceType = ""
    var fourDigitNumber: String {
    var result = ""
     repeat {
         // Create a string with a random number 0...9999
         result = String(format:"%04d", arc4random_uniform(10000) )
     } while Set<Character>(result).count < 4
     return result
    }
    
    let ref = Database.database().reference()
    
    /*UID generator*/
    /*We will need to check against all nodes to make sure no id is repeated*/
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    override func viewDidLoad() {
        
    self.SurveyButtonOutlet.layer.cornerRadius = 45
        
        super.viewDidLoad()
        /*Hides navigation bar*/
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Fetch face type
        ref.child("FaceType").observeSingleEvent(of: .value, with: { snapshot in
                  if let value = snapshot.value as? String{
                      if value == "Fox"{
                        //Change for real gif used
                        //self.Animoji.image = UIImage.gifImageWithName("funny")
                        self.Animoji.image = UIImage(named: "animoji-vos")
                        self.faceType = "animoji-vos"
                      }
                  } 
              })
        /*ref.child("TransitionState").child("Q1").observe(.value, with: {snapshot in
            print(snapshot)
             if let value = snapshot.value as? Int{
                if value == 1{
                    self.executeSegue(segueIdentifier: "Segue")
                }
            }
        })*/
    }
    
  /*Perform Segue*/
    func exitVC(segueIdentifier:String){
        /*Set user ID*/
        uid = randomString(length:5);
        //self.ref.child("Data").child(self.uid).child("Age").setValue("18-25")
        //self.ref.child("Data").child(self.uid).child("Emotion").setValue("Angry")
        //self.ref.child("Data").child(uid).child("Gender").setValue("Male")
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // let vc = segue.destination as! GDPR1
        //vc.text = self.faceType
        //vc.uid = self.uid
    }
    
    @IBAction func SurveyButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "PrivacySegue")
    }
}
