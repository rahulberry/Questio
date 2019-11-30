//
//  File.swift
//  Questio
//
//  Created by Rahul Berry on 27/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SurveyEndMech:UIViewController{
    var config = config_data()
    
    @IBOutlet weak var surveyID: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        for vc in (self.navigationController?.viewControllers ?? []) {
            print(vc)
                   if vc is SurveyStartM {
                   self.navigationController?.popToViewController(vc, animated: true)
                   break
                }
    }
    }
    
       
        
    @IBAction func Home(_ sender: Any) {
        for vc in (self.navigationController?.viewControllers ?? []) {
                   if vc is Home {
                   self.navigationController?.popToViewController(vc, animated: true)
                   break
                   }
               }
           
    }
    
       
}
