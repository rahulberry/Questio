//
//  LongAnswer.swift
//  Questio
//
//  Created by Rahul Berry on 18/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//


import UIKit

class LongAnswer:UIViewController{
    
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
        shuffled: false
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
