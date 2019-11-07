//
//  ViewController.swift
//  Questio
//
//  Created by Rahul Berry on 31/10/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit

import Firebase


class ViewController: UIViewController {
    
    @IBOutlet weak var Animoji: UIImageView!
    
    var faceType = ""
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*Hides navigation bar*/
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
        ref.child("FaceType").observeSingleEvent(of: .value, with: { snapshot in
                  if let value = snapshot.value as? String{
                      if value == "Fox"{
                        //Change for real gif used
                        //self.Animoji.image = UIImage.gifImageWithName("funny")
                        self.Animoji.image = UIImage(named: "animoji-vos")
                        self.faceType = "animji-vos"
                      }
                  }
              })
        /*ref.child("TransitionState").child("Q1").observe(.value, with: {snapshot in
            print(snapshot)
             if let value = snapshot.value as? Int{
                if value == 1{
                    self.executeSegue(segueIdentifier: "Segue")
                }
            }
        })*/
    }
    
    @IBAction func B(_ sender: Any) {
           self.executeSegue(segueIdentifier: "Segue")
       }
    
    /*Perform Segue*/
    func executeSegue(segueIdentifier:String){
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController2
        vc.text = self.faceType
    }
    
    
}
