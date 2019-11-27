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
    let ref = Database.database().reference()
    var newQuestion = [Question]()
    var config = config_data()
    var questionInfo:[String] = []
    @IBOutlet weak var videoView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref.child("Questions").child("0").observeSingleEvent(of: .value, with: { snapshot in
            let questionData = snapshot.value as? NSDictionary
            var test = questionData?.value(forKey: "1")
            print(test)
            let pathURL = URL.init(fileURLWithPath:  Bundle.main.path(forResource: "Q1"+self.config.Face_Type, ofType: "mp4")!)
            let player = AVPlayer(playerItem: AVPlayerItem(url: pathURL))
            let playerLayer = AVPlayerLayer(player: player)
            NotificationCenter.default.addObserver(self, selector: #selector(self.finishVideo), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            playerLayer.frame = .init(x: 0, y: 0, width: self.videoView.frame.width, height: self.videoView.frame.height)
            self.videoView.layer.addSublayer(playerLayer)
            player.play()
        })
                
       
               
        //self.Animoji.image = UIImage(named: self.config.Face_Type)
       
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
        DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
            print("video fin")
            self.exitVC(segueIdentifier: "Q1ResponseSegue")
        })
      }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
