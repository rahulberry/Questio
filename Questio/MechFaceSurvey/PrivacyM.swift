import UIKit
import Firebase
import AVFoundation

class PrivacyM:UIViewController{
    var config = config_data()
    var objPlayer: AVAudioPlayer?
    let cv = ComputerVision()
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    var AcceptPressed = false
    let ref = Database.database().reference()
    @IBOutlet weak var RedButton: UIView!
    @IBOutlet weak var GreenButton: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cv.setupCaptureSession()
        cv.setupDevice()
        cv.setupInputOutput()
        cv.startRunningCaptureSession()
        
        self.RedButton.layer.cornerRadius = 102
        self.GreenButton.layer.cornerRadius = 102

        guard let url = Bundle.main.url(forResource: "L1A", withExtension: "mp3") else { return }

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

        } catch let error {
            print(error.localizedDescription)
        }
        
        ref.child("Hardware_Interface").child("Current_State").setValue("Privacy")
        ref.child("Hardware_Interface").child("Privacy").observe(.value, with: {snapshot in
            print(snapshot)
             if let value = snapshot.value as? String{
                print(value)
                if(value == "No"){
                    self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
                    self.exitVC(segueIdentifier:"DeclinedM")
                }
                else if (value == "Yes") {
                    self.AcceptPressed = true
                    self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
                    self.config.surveyID = self.randomString(length: 6)
                    self.exitVC(segueIdentifier:"PrivOutSegueM")
                }
            }
    })
}
    
    func exitVC(segueIdentifier:String){
            cv.getResults()
        cv.group.notify(queue: DispatchQueue.main){
            print("test")
          //  self.config.surveyID = self.randomString(length: 6)
            print(self.cv.final_answer)
            self.ref.child("Data").child(self.config.surveySetID).child(self.config.surveyID).child("Age").setValue(self.cv.final_answer.age)
            self.ref.child("Data").child(self.config.surveySetID).child(self.config.surveyID).child("Mood_Start").setValue(self.cv.final_answer.emotion)
            self.ref.child("Data").child(self.config.surveySetID).child(self.config.surveyID).child("Gender").setValue(self.cv.final_answer.gender)
            self.performSegue(withIdentifier: segueIdentifier, sender: self)

        }

       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(self.AcceptPressed){
            let vc = segue.destination as! Question1M
              vc.config = self.config
        }
      }
}
