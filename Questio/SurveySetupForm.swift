//
//  SurveySetupForm.swift
//  Questio
//
//  Created by Rahul Berry on 13/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

class SurveySetupForm: UIViewController{
    
    let ref = Database.database().reference()

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
        self.IDLabel.text = randomString(length:10)
    }
    
    func exitVC(segueIdentifier:String){
        self.uploadData()
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    func uploadData(){
        self.ref.child("Data").child(self.IDLabel.text!).child("Additional_Information").setValue(self.TitleTB.text!)
    }
              
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
    }
    @IBAction func StartButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "SegueToSurvey")
    }
     @IBAction func BackButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "SegueToSurvey")
    }
}


