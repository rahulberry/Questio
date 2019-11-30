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

class Question1M:UIViewController{
    var config = config_data()
    var objPlayer: AVAudioPlayer?
    
    let cv = ComputerVision()
    let f = functions()    
    let ref = Database.database().reference()

    @IBOutlet weak var RedButton: UIView!
    @IBOutlet weak var GreenButton: UIView!
    @IBOutlet weak var YellowButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cv.setupCaptureSession()
         cv.setupDevice()
         cv.setupInputOutput()
         cv.startRunningCaptureSession()
        guard let url = Bundle.main.url(forResource: "Q1A", withExtension: "mp3") else { return }

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
                self.ref.child("Hardware_Interface").child("Face_State").setValue("R")
            })

        } catch let error {
            print(error.localizedDescription)
        }
        
        
        
        self.RedButton.layer.cornerRadius = 110
        self.GreenButton.layer.cornerRadius = 110
        self.YellowButton.layer.cornerRadius = 45

        ref.child("Hardware_Interface").child("Current_State").setValue("Q1")
        ref.child("Hardware_Interface").child("Input").setValue("Buttons")
        ref.child("Hardware_Interface").child("Q1").observe(.value, with: {snapshot in
            print(snapshot)
             if let value = snapshot.value as? String{
                print("test")
                if(value == "Yes"){
                    print(self.config.surveySetID)
                    self.ref.child("Hardware_Interface").child("Q1").setValue("rest")
                    self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Response")
                        .setValue(value)
                    self.exitVC(segueIdentifier:"Q2Segue")
                }
                else if (value == "No") {
                self.ref.child("Hardware_Interface").child("Q1").setValue("rest")
                   self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Response")
                        .setValue(value)
                self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
                    self.exitVC(segueIdentifier:"Q2Segue")
                }
                else if (value == "Skip") {
                self.ref.child("Hardware_Interface").child("Q1").setValue("rest")
                   self.ref.child("Data")
                        .child(self.config.surveySetID)
                        .child(self.config.surveyID)
                        .child("Q1").child("Response")
                        .setValue(value)
                    self.exitVC(segueIdentifier:"Q2Segue")
                }
            }
    })
}
    func exitVC(segueIdentifier:String){
        print("124")
        cv.getResults()
        cv.group.notify(queue: .main){
            print(self.cv.final_answer)
            self.ref.child("Data")
                .child(self.config.surveySetID)
                .child(self.config.surveyID)
                .child("Q1").child("Mood")
                .setValue(self.cv.final_answer.emotion)
            self.ref.child("Data")
                .child(self.config.surveySetID)
                .child(self.config.surveyID)
                .child("Q1").child("Time")
                .setValue(self.f.stringFromDate(Date()))
        self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
            self.performSegue(withIdentifier: segueIdentifier, sender: self)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let vc = segue.destination as! Question2M
          vc.config = self.config
      }
}

