//
//  Setup.swift
//  Questio
//
//  Created by Rahul Berry on 15/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

struct config_data{
    var Data_Notice = ""
    var Experiment_Type = ""
    var Face_Type = ""
    var Hypothesis = ""
    var Personal_Limit = 0
    var Personal_Timed = false
    var Privacy_Code = false
    var Short_Limit = 50
    var Short_Timed = false
    var Time_Creted = ""
    var Title = ""
    var shuffled = false
    var surveySetID = ""
    var surveyID = ""
}

var faceType = ""
let ref = Database.database().reference()

class Setup:UIViewController{
    let reference = ref.child("Configurations")
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        
        // Fetch face type
        
        self.reference.child("Test1").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                /*fetch data here*/
                //If statement to check face type
                self.config.Face_Type = "Mechanical_Face"
                self.config.Privacy_Code = false
                
            }
        })
        
        
    }
    
    func exitVC(segueIdentifier:String){
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
              
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SurveyDetailsForm
        vc.config = self.config
    }
              
    
    @IBAction func Button(_ sender: Any) {
    
    }
}
