//
//  ViewController2.swift
//  Questio
//
//  Created by Rahul Berry on 03/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

class GDPR1: UIViewController {
    
    let ref = Database.database().reference()
    let data = cvData(Mood: "", Age: 0, Gender: "")
    var Face_Type:String = "animoji-vos"
    var uid:String = ""
    var config = config_data()

    
    @IBOutlet weak var Animoji: UIImageView!
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        
        //fix state management
        self.Animoji.image = UIImage(named: Face_Type)
        
    }
    
   
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PrivacyResponse
        vc.config = self.config
    }

    class func postData(){
       // self.ref.child("Data").setValue("Test")
    }
    func exitVC(segueIdentifier:String){
          // self.postData()
           self.performSegue(withIdentifier: segueIdentifier, sender: self)
        
    }

    @IBAction func NextButton(_ sender: Any) {
        self.exitVC(segueIdentifier: "PrivacyResponse2")
    }
}
