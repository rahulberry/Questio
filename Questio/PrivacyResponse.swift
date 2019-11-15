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
    
    var Face_Type = "animoji-vos"
    var uid = ""

    let ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Animoji.image = UIImage(named: Face_Type)
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
    }
    
    @IBAction func DeclineButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "DeclinedSegue")
    }
     @IBAction func AcceptButton(_ sender: Any) {
        /*Set user ID & transition*/
        uid = randomString(length: 6)
        self.ref.child("Data").child(self.uid).child("Age").setValue("X")
        self.ref.child("Data").child(self.uid).child("Mood").setValue("X")
        self.ref.child("Data").child(self.uid).child("Gender").setValue("X")
        self.exitVC(segueIdentifier: "StartSurvey")
    }
    
}
