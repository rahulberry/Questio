//
//  SurveyStartM.swift
//  Questio
//
//  Created by Rahul Berry on 20/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

class SurveyStartM: UIViewController{
    @IBOutlet weak var GreenButton: UIView!
    @IBOutlet weak var PressLabel: UILabel!
    var stringOne = "Press the green button to start"
    let stringTwo = "green"
    
    var config = config_data()
    let ref = Database.database().reference()
    

    override func viewDidLoad(){
        super.viewDidLoad()
        let range = (stringOne as NSString).range(of: stringTwo)
        let attributedText = NSMutableAttributedString.init(string: stringOne)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green , range: range)
        self.PressLabel.attributedText = attributedText
        self.GreenButton.layer.cornerRadius = 110
        
        ref.child("Hardware_Interface").child("Current_State").setValue("Welcome")
        ref.child("Hardware_Interface").child("Welcome").observe(.value, with: {snapshot in
            print(snapshot)
             if let value = snapshot.value as? String{
                print(value)
                if value == "Yes"{
                    self.ref.child("Hardware_Interface").child("Welcome").setValue("rest")
                    self.ref.child("Hardware_Interface").child("Face_State").setValue("B")
                    self.exitVC(segueIdentifier:"PrivSegueM")
                }
            }
        })
    }
    
    func exitVC(segueIdentifier:String){
           self.performSegue(withIdentifier: segueIdentifier, sender: self)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let vc = segue.destination as! PrivacyM
          vc.config = self.config
      }
}

