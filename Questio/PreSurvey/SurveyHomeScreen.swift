//
//  ViewController.swift
//  Questio
//
//  Created by Rahul Berry on 31/10/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

class SurveyHomeScreen: UIViewController {
    
    @IBOutlet weak var Animoji: UIImageView!
    @IBOutlet weak var SurveyButtonOutlet: UIButton!

    var Privacy_Code = false
    var uid = ""
    var faceType = ""
    let ref = Database.database().reference()
    var config = config_data()
/*UID generator*/
    /*We will need to check against all nodes to make sure no id is repeated*/
    
    
    override func viewDidLoad() {
        
    self.SurveyButtonOutlet.layer.cornerRadius = 45
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    
        // Fetch face type
        //Change for real gif used
        //self.Animoji.image = UIImage.gifImageWithName("funny")
        if(self.config.Face_Type == "F"){
            self.Animoji.image = UIImage(named: "animoji-vos")
        }
        else if(self.config.Face_Type == "S"){
            //fill
        }

    }
    
  /*Perform Segue*/
    func exitVC(segueIdentifier:String){
        print(self.config.Data_Notice)
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! Welcome
            vc.config = self.config
    }
    
    @IBAction func SurveyButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "WelcomeSegue")
    }
}
