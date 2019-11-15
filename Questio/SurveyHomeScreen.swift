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
    
    var Privacy_Code = false
    var uid = ""
    var faceType = ""
    
    let ref = Database.database().reference()
    
    /*UID generator*/
    /*We will need to check against all nodes to make sure no id is repeated*/
    
    
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
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // let vc = segue.destination as! GDPR1
        //vc.text = self.faceType
    }
    
    @IBAction func SurveyButton(_ sender: Any) {
        if(self.Privacy_Code){
            self.exitVC(segueIdentifier: "GDPRSegue")
        }else{
            self.exitVC(segueIdentifier: "PrivacySegue")
        }
    }
}
