//
//  Question1.swift
//  Questio
//
//  Created by Rahul Berry on 17/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import AVKit

class Question:UIViewController{
    let ref = Database.database().reference()
    var config = config_data()
    var questionInfo:[String] = []
    var current_question:String = ""
    var data = ""
    var qData = questionData()
    @IBOutlet weak var videoView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        self.ref.child("Current_Question").observeSingleEvent(of: .value, with: { snapshot in
                  print(snapshot)
                  if let value = snapshot.value as? Int{
                      self.config.Current_Question = String(value)
                      let pathURL = URL.init(fileURLWithPath:  Bundle.main.path(forResource: "Q" + self.config.Current_Question + self.config.Face_Type, ofType: "mp4")!)
                           let player = AVPlayer(playerItem: AVPlayerItem(url: pathURL))
                             let playerLayer = AVPlayerLayer(player: player)
                             NotificationCenter.default.addObserver(self, selector: #selector(self.finishVideo), name: .AVPlayerItemDidPlayToEndTime, object: nil)
                             playerLayer.frame = .init(x: 0, y: 0, width: self.videoView.frame.width, height: self.videoView.frame.height)
                             self.videoView.layer.addSublayer(playerLayer)
                             player.play()
                  }
                  self.ref.child("Questions").child("short").child("Q"+self.config.Current_Question).observeSingleEvent(of: .value, with: { snapshot in
                      let questionData = snapshot.value as? NSDictionary
                      self.qData.format = questionData?["Type"] as! String
                      self.qData.Question = questionData?["Question"] as! String
                      self.qData.optOne = questionData?["1"] as! String
                      self.qData.optTwo = questionData?["2"] as! String
                      self.qData.optThree = questionData?["3"] as! String
                      self.qData.optFour = questionData?["4"] as! String
                      self.qData.optFive = questionData?["5"] as! String
                      }
                  )
              })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    func exitVC(segueIdentifier:String){
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
       }
       
       /*Pass data across view controllers*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(self.qData)
        if(self.qData.format == "y/n"){
            let vc = segue.destination as! YNResponse
            vc.config = self.config
            vc.qData = self.qData
        }
        else if(self.qData.format == "five"){
            let vc = segue.destination as! FiveScaleResponse
            vc.config = self.config
            vc.qData = self.qData
        }
        
       
    }
    @objc func finishVideo(note: NSNotification){
        DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
          if(self.qData.format == "y/n"){
            self.exitVC(segueIdentifier: "YNSegue")
        }
          else if(self.qData.format == "five"){
            self.exitVC(segueIdentifier: "FiveScaleSegue")
        }
        })
      }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
