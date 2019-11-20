//
//  Home.swift
//  Questio
//
//  Created by Rahul Berry on 13/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase

var setupCheck = 0

var imagePicker: UIImagePickerController!

class Home: UIViewController{
    @IBOutlet weak var SurveyCountButtonOutlet: UIButton!
    @IBOutlet weak var StartButtonOutlet: UIButton!
    @IBOutlet weak var SurveyLabel: UILabel!
    @IBOutlet weak var CompletedLabel: UILabel!
    @IBOutlet weak var CSContainer: UIView!
    @IBOutlet weak var SetupsOutlet: UIButton!
    @IBOutlet weak var SetupsContainer: UIView!
    @IBOutlet weak var picture: UIImageView!
    
    //let cv = ComputerVision()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        /*Computer Vision Setup*/
        /*cv.setupCaptureSession()
        cv.setupDevice()
        cv.setupInputOutput()
        cv.startRunningCaptureSession()*/

        self.StartButtonOutlet.layer.cornerRadius = 150
        self.SurveyCountButtonOutlet.layer.cornerRadius = 35
        self.CSContainer.layer.cornerRadius = 35
        self.SetupsOutlet.layer.cornerRadius = 35
        self.SetupsContainer.layer.cornerRadius = 35
        let currentDateTime = Date()
        self.SurveyLabel.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi / 2)
        self.CompletedLabel.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi / 2)
       
    }
   
    
           
        func exitVC(segueIdentifier:String){
            self.performSegue(withIdentifier: segueIdentifier, sender: self)
        }
           
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        }
           
        @IBAction func SetupsButton(_ sender: Any) {
            //cv.getResult()
        }
        
        @IBAction func SurveyCountButton(_ sender: Any) {

        }
    
        @IBAction func StartButton(_ sender: Any) {
            self.exitVC(segueIdentifier: "SegueToSetup")
        }
    
        @IBAction func SetupButton(_ sender: Any){
            self.exitVC(segueIdentifier: "SetupSegue")
        }

    }


