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

class Question3:UIViewController{
       var config = config_data()
        
    
    @IBOutlet weak var videoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.Animoji.image = UIImage(named: self.config.Face_Type)
        let pathURL = URL.init(fileURLWithPath:  Bundle.main.path(forResource: "Q3"+self.config.Face_Type, ofType: "mp4")!)
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
           let vc = segue.destination as! FiveScaleResponse
           vc.config = self.config
       }
    @objc func finishVideo(note: NSNotification){
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.5, execute: {
            print("video fin")
            self.exitVC(segueIdentifier: "Q3ResponseSegue")
        })
      }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }


}
