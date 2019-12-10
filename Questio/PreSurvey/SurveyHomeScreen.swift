//
//  ViewController.swift
//  Questio
//
//  Created by Rahul Berry on 31/10/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import AVKit

class SurveyHomeScreen: UIViewController {

    @IBOutlet weak var SurveyButtonOutlet: UIButton!

    var objPlayer: AVAudioPlayer?
    let url = Bundle.main.url(forResource: "approachAudio", withExtension: "mp3")
    var Privacy_Code = false
    var uid = ""
    var faceType = ""
    let ref = Database.database().reference()
    var config = config_data()
    var pause = false
    var player:AVPlayer?
    
    override func viewDidLoad() {
        ref.child("Reset").observe(.value, with: {snapshot in
               if let value = snapshot.value as? Bool{
                   if(value){
                       self.ref.child("Reset").setValue(false)
                       for vc in (self.navigationController?.viewControllers ?? []) {
                           if vc is SurveyHomeScreen {
                               self.navigationController?.popToViewController(vc, animated: true)
                               break
                       }
                   }
               }
           }
           })
    self.SurveyButtonOutlet.layer.cornerRadius = 45
    
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        self.playAudio()
        ref.child("Approach_Question").observe(.value, with: {snapshot in
            if let value = snapshot.value as? String{
                 if(value == "V1"){
                    self.playAudio()
                }
                else if (value == "V2"){
                    
                }
                else if (value == "V3"){
                        
                }
                else if (value == "V4"){
                        
                }
                else if (value == "V5"){
                                
                }
            }
        })
    }
    
  /*Perform Segue*/
    func exitVC(segueIdentifier:String){
        print(self.config.Data_Notice)
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    func playAudio(){
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            let asset = AVURLAsset(url: self.url!, options: nil)
            let audioDuration = asset.duration
            let audioDurationSeconds = CMTimeGetSeconds(audioDuration)
            ref.child("Hardware_Interface").child("Audio").setValue(Int(audioDurationSeconds))
        
            // For iOS 11
            objPlayer = try AVAudioPlayer(contentsOf: self.url!, fileTypeHint: AVFileType.mp3.rawValue)
            print("test")
            objPlayer?.play()
            DispatchQueue.main.asyncAfter(deadline:.now() + audioDurationSeconds, execute: {
                self.ref.child("Hardware_Interface").child("Face_State").setValue("R")
            })

        } catch let error {
            print(error.localizedDescription)
        }
        
        self.ref.child("Approach_Question").setValue(false)
    }
    
    /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! Introduction
            vc.config = self.config
    }
    
    @IBAction func SurveyButton(_ sender: Any) {
        player?.pause()
        self.exitVC(segueIdentifier: "WelcomeSegue")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
