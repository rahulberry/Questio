//
//  Q2Response.swift
//  Questio
//
//  Created by Rahul Berry on 26/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//


import UIKit
import Firebase

class Q2Response:UIViewController{
    var word = ""
    let ref = Database.database().reference()
    var config = config_data()
    var response = ""
    let sr = SpeechProcessing()

    func giveKeyWord(keyWord: String){
        self.response = keyWord
        print("got answer")
        sr.cancelRecognition()
        print(self.response)
        exitVC(segueIdentifier: "Q3Segue")
    }
    

    @IBOutlet weak var YesButtonOutlet: UIButton!
    @IBOutlet weak var NoButtonOutlet: UIButton!
    @IBOutlet weak var Animoji: UIImageView!
    @IBOutlet weak var textSR: UITextView!
    override func viewDidLoad() {
        
        sr.sharedVars(textSR!)

        super.viewDidLoad()
        sr.begin(keywords: ["Yes", "No", "Skip"], callBack: giveKeyWord)
        if(self.config.Face_Type == "F"){
            self.Animoji.image = UIImage(named: "animoji-vos")
        }
        else{
            
        }
        self.YesButtonOutlet.layer.cornerRadius = 50
        self.NoButtonOutlet.layer.cornerRadius = 50
    }
    
    func exitVC(segueIdentifier:String){
        self.ref.child("Data")
            .child(self.config.surveySetID)
            .child(self.config.surveyID)
            .child("Q2").child("Response")
            .setValue(self.response)
        self.ref.child("Data")
            .child(self.config.surveySetID)
            .child(self.config.surveyID)
            .child("Q2").child("Mood")
            .setValue("XX")
        self.ref.child("Data")
            .child(self.config.surveySetID)
            .child(self.config.surveyID)
            .child("Q2").child("Time")
            .setValue(stringFromDate(Date()))
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! Question3
        vc.config = self.config
    }
    @IBAction func YesButton(_ sender: Any) {
        self.response = "Yes"
        self.exitVC(segueIdentifier: "Q3Segue")
    }
   
    @IBAction func NoButton(_ sender: Any) {
        self.response = "No"
        self.exitVC(segueIdentifier: "Q3Segue")
    }
    
    func stringFromDate(_ date: Date) -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
          return formatter.string(from: date)
      }
    
    @IBAction func SkipButton(_ sender: Any) {
        self.response = "Skip"
        self.exitVC(segueIdentifier: "Q3Segue")
       }
    
}
