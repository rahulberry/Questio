//
//  File.swift
//  Questio
//
//  Created by Rahul Berry on 25/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var config = config_data()


class Question:UIViewController {
    override func viewDidLoad() {
           super.viewDidLoad()
        print(config.Current_Question)
       }
}
