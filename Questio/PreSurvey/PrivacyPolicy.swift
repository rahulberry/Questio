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
        
        let vc = segue.destination as! PrivacyResponse
        vc.config = self.config
    }
    
    @IBAction func NextButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "PrivacyResponse")
    }
}
