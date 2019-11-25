//
//  Question1Response.swift
//  Questio
//
//  Created by Rahul Berry on 17/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

class YNResponse:UIViewController{
    
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
           shuffled: false,
           surveySetID: "",
           surveyID: ""
        )
    
    var response = "Skip"
    @IBOutlet weak var Animoji: UIImageView!
    @IBOutlet weak var YesButtonOutlet: UIButton!
    @IBOutlet weak var NoButtonOutlet: UIButton!
    @IBOutlet weak var SkipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Animoji.image = UIImage(named: self.config.Face_Type)
        self.YesButtonOutlet.layer.cornerRadius = 45
        self.NoButtonOutlet.layer.cornerRadius = 45
    }
    

  
    func exitVC(segueIdentifier:String){
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! Question2
        vc.config = self.config
    }
    @IBAction func YesButton(_ sender: Any) {
        if(self.YesButtonOutlet.backgroundColor == UIColor.white){
            self.YesButtonOutlet.backgroundColor = UIColor.init(red: 186/255, green: 244/255, blue: 255/255, alpha: 1)
            self.NoButtonOutlet.backgroundColor = UIColor.white
            self.SkipLabel.text = "Next"
            self.response = "Yes"
        }
        else{
            self.YesButtonOutlet.backgroundColor = UIColor.white
            self.SkipLabel.text = "Skip"
            self.response = "Skip"
        }
    }
   
    @IBAction func NoButton(_ sender: Any) {
        if(self.NoButtonOutlet.backgroundColor == UIColor.white){
            self.NoButtonOutlet.backgroundColor = UIColor.init(red: 186/255, green: 244/255, blue: 255/255, alpha: 1)
            self.YesButtonOutlet.backgroundColor = UIColor.white
            self.SkipLabel.text = "Next"
            self.response = "No"

              }
        else{
            self.NoButtonOutlet.backgroundColor = UIColor.white
            self.SkipLabel.text = "Skip"
            self.response = "Skip"
        }
    }
    
    func stringFromDate(_ date: Date) -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
          return formatter.string(from: date)
      }
    
    @IBAction func SkipButton(_ sender: Any) {
        self.ref.child("Data")
            .child(self.config.surveySetID)
            .child(self.config.surveyID)
            .child("Q1").child("Response")
            .setValue(self.response)
        self.ref.child("Data")
            .child(self.config.surveySetID)
            .child(self.config.surveyID)
            .child("Q1").child("Mood")
            .setValue("XX")
        self.ref.child("Data")
            .child(self.config.surveySetID)
            .child(self.config.surveyID)
            .child("Q1").child("Time")
            .setValue(stringFromDate(Date()))
        self.exitVC(segueIdentifier: "Q2Segue")

       }
    
}
