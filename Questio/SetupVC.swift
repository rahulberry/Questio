//
//  SetupVC.swift
//  Questio
//
//  Created by Rahul Berry on 14/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

struct config_data {
    var Data_Notice = false
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
}
class SetupVC: UIViewController {
        override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        
            
            
            
    }
}

