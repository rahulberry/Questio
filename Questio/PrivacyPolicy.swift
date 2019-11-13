//
//  PrivacyPolicy.swift
//  Questio
//
//  Created by Rahul Berry on 13/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase


var text = ""

class PrivacyPolicy: UIViewController {
    
    @IBOutlet weak var Animoji: UIImageView!

   override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        
        //fix state management
        self.Animoji.image = UIImage(named: text)
        
    }
}
