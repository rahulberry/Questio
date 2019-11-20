//
//  PrivacyResponse.swift
//  Questio
//
//  Created by Rahul Berry on 15/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

class PrivacyResponse:UIViewController{
    @IBOutlet weak var DeclineButtonOutlet: UIButton!
    @IBOutlet weak var AcceptButtonOutlet: UIButton!
    @IBOutlet weak var Animoji: UIImageView!
    
    var uid = ""
    var AcceptPressed = false
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
           shuffled: false,
           surveySetID: "",
           surveyID: ""
        )

    let ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Animoji.image = UIImage(named: self.config.Face_Type)
        self.AcceptButtonOutlet.layer.cornerRadius = 45
        self.DeclineButtonOutlet.layer.cornerRadius = 45
    }
    
    func randomString(length: Int) -> String {
         let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
         return String((0..<length).map{ _ in letters.randomElement()! })
       }
    
    func exitVC(segueIdentifier:String){
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
                 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(self.AcceptPressed){
            let vc = segue.destination as! Question1
            vc.config = self.config
        }
    }
    
    @IBAction func DeclineButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "DeclinedSegue")
    }
     @IBAction func AcceptButton(_ sender: Any) {
        /*Set user ID & transition*/
        self.config.surveyID = randomString(length: 6)
        self.ref.child("Data").child(self.config.surveySetID).child(self.config.surveyID).child("Age").setValue("X")
        self.ref.child("Data").child(self.config.surveySetID).child(self.config.surveyID).child("Mood_Start").setValue("X")
        self.ref.child("Data").child(self.config.surveySetID).child(self.config.surveyID).child("Gender").setValue("X")
       
        self.AcceptPressed = true
        self.exitVC(segueIdentifier: "StartSurvey")
    }
    
}
