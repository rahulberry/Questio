import UIKit
import Firebase

class PrivacyM:UIViewController{
    var config = config_data()

    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    let ref = Database.database().reference()
    @IBOutlet weak var RedButton: UIView!
    @IBOutlet weak var GreenButton: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.RedButton.layer.cornerRadius = 102
        self.GreenButton.layer.cornerRadius = 102

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
                    self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
                    self.config.surveyID = self.randomString(length: 6)
                    self.exitVC(segueIdentifier:"PrivOutSegueM")   
                }
            }
    })
}
    
    func exitVC(segueIdentifier:String){
           self.performSegue(withIdentifier: segueIdentifier, sender: self)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let vc = segue.destination as! Question1M
          vc.config = self.config
      }
}
