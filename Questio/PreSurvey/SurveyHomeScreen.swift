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
    var config = config_data(
         Data_Notice: "",
         Experiment_Type: "",
         Face_Type: "",
         Hypothesis: "",
         Personal_Limit: 0,
         Personal_Timed: false,
         Privacy_Code: false,
         Short_Limit: 50,
         Short_Timed: false,
         Time_Creted: "",
         Title: "",
         shuffled: false
     )    /*UID generator*/
    /*We will need to check against all nodes to make sure no id is repeated*/
    
    
    override func viewDidLoad() {
        
    self.SurveyButtonOutlet.layer.cornerRadius = 45
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Fetch face type
        //Change for real gif used
        //self.Animoji.image = UIImage.gifImageWithName("funny")
        self.Animoji.image = UIImage(named: self.config.Face_Type)
        
            
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
        if(self.config.Privacy_Code){
            let vc = segue.destination as! GDPR1
            vc.config = self.config
        }else{
            let vc = segue.destination as! PrivacyPolicy
            vc.config = self.config
        }
    }
    
    @IBAction func SurveyButton(_ sender: Any) {
        if(self.Privacy_Code){
            self.exitVC(segueIdentifier: "GDPRSegue")
        }else{
            self.exitVC(segueIdentifier: "PrivacySegue")
        }
    }
}
