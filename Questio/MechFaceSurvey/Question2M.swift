//
//  Question1M.swift
//  Questio
//
//  Created by Rahul Berry on 27/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation

class Question2M:UIViewController{
    var config = config_data()
    var objPlayer: AVAudioPlayer?
    @IBOutlet weak var Label1: UIView!
    @IBOutlet weak var Label2: UIView!
    @IBOutlet weak var Label3: UIView!
    @IBOutlet weak var Label4: UIView!
    @IBOutlet weak var Label5: UIView!
    @IBOutlet weak var GreenButton: UIView!
    
    let f = functions()
    let ref = Database.database().reference()
    var sliderAnswer = ""
    
    let cv = ComputerVision()

    override func viewDidLoad() {
        self.Label1.layer.cornerRadius = 89.5
        self.Label2.layer.cornerRadius = 89.5
        self.Label3.layer.cornerRadius = 89.5
        self.Label4.layer.cornerRadius = 89.5
        self.Label5.layer.cornerRadius = 89.5

        cv.setupCaptureSession()
        cv.setupDevice()
        cv.setupInputOutput()
        cv.startRunningCaptureSession()
        
        super.viewDidLoad()
        guard let url = Bundle.main.url(forResource: "Q9A", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            let asset = AVURLAsset(url: url, options: nil)
            let audioDuration = asset.duration
            let audioDurationSeconds = CMTimeGetSeconds(audioDuration)
            ref.child("Hardware_Interface").child("Audio").setValue(Int(audioDurationSeconds))
            // For iOS 11
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            // For iOS versions < 11
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let aPlayer = objPlayer else { return }
            aPlayer.play()
            DispatchQueue.main.asyncAfter(deadline:.now() + audioDurationSeconds, execute: {
                self.ref.child("Hardware_Interface").child("Face_State").setValue("B")
            })

            
        } catch let error {
            print(error.localizedDescription)
        }
        
        print(config)
        self.GreenButton.layer.cornerRadius = 45

        ref.child("Hardware_Interface").child("Current_State").setValue("Q2")
        ref.child("Hardware_Interface").child("Input").setValue("Slider")
        ref.child("Hardware_Interface").child("Current_Slider_Value").observe(.value, with: {snapshot in
        if let value = snapshot.value as? String{
            
            print(value)
            if(value=="1"){
                self.Label1.backgroundColor = .blue
                self.Label2.backgroundColor = .white
                self.Label3.backgroundColor = .white
                self.Label4.backgroundColor = .white
                self.Label5.backgroundColor = .white
                self.sliderAnswer = "1"
            }
            if(value=="2"){
                self.Label2.backgroundColor = .blue
                self.Label1.backgroundColor = .white
                self.Label3.backgroundColor = .white
                self.Label4.backgroundColor = .white
                self.Label5.backgroundColor = .white
                self.sliderAnswer = "2"
            }
            if(value=="3"){
                self.Label3.backgroundColor = .blue
                self.Label2.backgroundColor = .white
                self.Label1.backgroundColor = .white
                self.Label4.backgroundColor = .white
                self.Label5.backgroundColor = .white
                self.sliderAnswer = "3"
            }
            if(value=="4"){
                self.Label4.backgroundColor = .blue
                self.Label2.backgroundColor = .white
                self.Label3.backgroundColor = .white
                self.Label1.backgroundColor = .white
                self.Label5.backgroundColor = .white
                self.sliderAnswer = "4"
            }
            if(value=="5"){
                self.Label5.backgroundColor = .blue
                self.Label2.backgroundColor = .white
                self.Label3.backgroundColor = .white
                self.Label4.backgroundColor = .white
                self.Label1.backgroundColor = .white
                self.sliderAnswer = "5"
                }
            else if (value == "rest"){
                self.Label1.backgroundColor = .white
                self.Label2.backgroundColor = .white
                self.Label3.backgroundColor = .white
                self.Label4.backgroundColor = .white
                self.Label5.backgroundColor = .white
                }
            }
       
        })
        ref.child("Hardware_Interface").child("Q2").observe(.value, with: {snapshot in
            print(snapshot)
             if let value = snapshot.value as? String{
                print("test")
                if(value == "Yes"){
                    print(self.config.surveySetID)
                    self.ref.child("Hardware_Interface").child("Q1").setValue("rest")
                    self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q2").child("Response")
                        .setValue(self.sliderAnswer)
                    self.exitVC(segueIdentifier:"Q2Segue")
                }
                
                else if (value == "Skip") {
                self.ref.child("Hardware_Interface").child("Q1").setValue("rest")
                   self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q2").child("Response")
                    .setValue(self.sliderAnswer)
                   
                self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
                    self.exitVC(segueIdentifier:"Q2Segue")
                }
            }
    })
}
    func exitVC(segueIdentifier:String){
        self.ref.child("Hardware_Interface").child("Current_State").setValue("Welcome")

        self.ref.child("Hardware_Interface").child("Q2").setValue("rest")
        cv.getResults()
        cv.group.notify(queue: .main){
            print(self.cv.final_answer)
        self.ref.child("Data")
            .child(self.config.surveySetID)
            .child(self.config.surveyID)
            .child("Q2").child("Mood")
            .setValue(self.cv.final_answer.emotion)
        self.ref.child("Data")
            .child(self.config.surveySetID)
            .child(self.config.surveyID)
            .child("Q2").child("Time")
            .setValue(self.f.stringFromDate(Date()))
        self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
            self.performSegue(withIdentifier: segueIdentifier, sender: self)

        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          //let vc = segue.destination as! YNResponse
          //vc.config = self.config
      }
}

