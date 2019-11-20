//
//  SurveySetupForm.swift
//  Questio
//
//  Created by Rahul Berry on 13/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

class SurveyDetailsForm: UIViewController{
    
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
    /*used to set survey ID*/
    func randomString(length: Int) -> String {
        /*Code needs to be added to make sure no 2 IDs are the same*/
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    @IBOutlet weak var NotesBox: UIView!
    @IBOutlet weak var LocationBox: UIView!
    @IBOutlet weak var IDBox: UIView!
    @IBOutlet weak var Duration: UIView!
    @IBOutlet weak var SurveyTitleBox: UIView!
    @IBOutlet weak var StartButtonOutlet: UIButton!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var TitleTB: UITextView!
    @IBOutlet weak var LocationTB: UITextView!
    @IBOutlet weak var DurationTB: UITextView!
    @IBOutlet weak var NotesTB: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.NotesBox.layer.cornerRadius = 50
        self.LocationBox.layer.cornerRadius = 50
        self.SurveyTitleBox.layer.cornerRadius = 50
        self.IDBox.layer.cornerRadius = 50
        self.Duration.layer.cornerRadius = 50
        self.StartButtonOutlet.layer.cornerRadius = 150
        self.config.surveySetID = randomString(length: 10)
        self.IDLabel.text = self.config.surveySetID
    }
    
    func exitVC(segueIdentifier:String){
        self.uploadData()
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    func uploadData(){
        self.ref.child("Data").child(self.config.surveySetID).child("Additional_Information").setValue(self.TitleTB.text!)
        self.ref.child("Data").child(self.config.surveySetID).child("Creation_Time").setValue(stringFromDate(Date()))
    }
              
    func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
        return formatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SurveyHomeScreen
        vc.config = self.config
    }
    @IBAction func StartButton(_ sender: Any) {
        if(self.config.Face_Type == "Mechanical_Face"){
            self.exitVC(segueIdentifier:"MechanicalSegue")
        }
        else{
            self.exitVC(segueIdentifier: "SegueToSurvey")
        }
    }
     @IBAction func BackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)      
    }
}


