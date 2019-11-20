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

class Question1:UIViewController{
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
    
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.Animoji.image = UIImage(named: self.config.Face_Type)
        let pathURL = URL.init(fileURLWithPath:  Bundle.main.path(forResource: "TestQuaestio2", ofType: "mp4")!)
        let player = AVPlayer(playerItem: AVPlayerItem(url: pathURL))
        let playerLayer = AVPlayerLayer(player: player)

        NotificationCenter.default.addObserver(self, selector: #selector(finishVideo), name: .AVPlayerItemDidPlayToEndTime, object: nil)

        playerLayer.frame = .init(x: 0, y: 0, width: videoView.frame.width, height: videoView.frame.height)
        self.videoView.layer.addSublayer(playerLayer)
        player.play()
        
    }
    func exitVC(segueIdentifier:String){
           self.performSegue(withIdentifier: segueIdentifier, sender: self)
       }
       
       /*Pass data across view controllers*/
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let vc = segue.destination as! YNResponse
           vc.config = self.config
       }
    @objc func finishVideo(note: NSNotification){
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.5, execute: {
            print("video fin")
            self.exitVC(segueIdentifier: "Q1ResponseSegue")
        })
      }
    

}
