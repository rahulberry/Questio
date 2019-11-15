//
//  PrivacyPolicy.swift
//  Questio
//
//  Created by Rahul Berry on 13/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase



class PrivacyPolicy: UIViewController {
    var Face_Type = "animoji-vos"

    @IBOutlet weak var NextButtonOutlet: UIButton!
    @IBOutlet weak var Animoji: UIImageView!

   override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        
        //fix state management
        self.Animoji.image = UIImage(named: Face_Type)
        
    }
    
    func exitVC(segueIdentifier:String){
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
              
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func NextButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "PrivacyResponse")
    }
}
