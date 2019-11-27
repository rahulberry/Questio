//
//  Question1M.swift
//  Questio
//
//  Created by Rahul Berry on 27/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Question1M:UIViewController{
    var config = config_data()
    let f = functions()
    
    let ref = Database.database().reference()

    @IBOutlet weak var RedButton: UIView!
    @IBOutlet weak var GreenButton: UIView!
    @IBOutlet weak var YellowButton: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(config)
        self.RedButton.layer.cornerRadius = 110
        self.GreenButton.layer.cornerRadius = 110

        ref.child("Hardware_Interface").child("Current_State").setValue("Q1")
        ref.child("Hardware_Interface").child("Input").setValue("Buttons")
        ref.child("Hardware_Interface").child("Q1").observe(.value, with: {snapshot in
            print(snapshot)
             if let value = snapshot.value as? String{
                print("test")
                if(value == "Yes"){
                    print(self.config.surveySetID)
                    self.ref.child("Hardware_Interface").child("Q1").setValue("rest")
                    self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Response")
                        .setValue(value)
                    self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Mood")
                        .setValue("XX")
                    self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Time")
                        .setValue(self.f.stringFromDate(Date()))
                    self.exitVC(segueIdentifier:"Q2Segue")
                }
                else if (value == "No") {
                    self.ref.child("Hardware_Interface").child("Q1").setValue("rest")
                   self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Response")
                        .setValue(value)
                    self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Mood")
                        .setValue("XX")
                    self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Time")
                        .setValue(self.f.stringFromDate(Date()))
                self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
                    self.exitVC(segueIdentifier:"Q2Segue")
                }
            }
    })
}
    func exitVC(segueIdentifier:String){
           self.performSegue(withIdentifier: segueIdentifier, sender: self)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          //let vc = segue.destination as! YNResponse
          //vc.config = self.config
      }
}

