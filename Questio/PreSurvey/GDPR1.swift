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

    

    @IBOutlet weak var Animoji: UIImageView!
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
        
        //fix state management
        self.Animoji.image = UIImage(named: Face_Type)
        
    }
    
   
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*This is the segue from VC1 to this VC edit for further*/
        //let vc = segue.destination as! ViewController2
        //vc.text = self.faceType
    }
    
    class func postData(){
       // self.ref.child("Data").setValue("Test")
    }
    func exitVC(segueIdentifier:String){
          // self.postData()
           self.performSegue(withIdentifier: segueIdentifier, sender: self)
       }
    func compVision() -> cvData{
        /*Obtain CV results*/
        let data = cvData(Mood: "Angry", Age: 0, Gender: "Male")
        return data
    }
    
    func speechRecognition(){
        
    }
    
}
