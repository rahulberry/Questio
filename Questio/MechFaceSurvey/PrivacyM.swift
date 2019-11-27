import UIKit
import Firebase

class PrivacyM:UIViewController{
    let ref = Database.database().reference()

    @IBOutlet weak var RedButton: UIView!
    @IBOutlet weak var GreenButton: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.RedButton.layer.cornerRadius = 105
        self.GreenButton.layer.cornerRadius = 105

        ref.child("Hardware_Interface").child("Current_State").setValue("Privacy")
        ref.child("Hardware_Interface").child("Privacy").observe(.value, with: {snapshot in
            print(snapshot)
             if let value = snapshot.value as? String{
                print(value)
                if(value == "Yes"){
                    self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
                    self.exitVC(segueIdentifier:"DeclinedM")
                }
                else if (value == "No") {
                self.ref.child("Hardware_Interface").child("Privacy").setValue("rest")
                                    self.exitVC(segueIdentifier:"PrivOutSegueM")
                }
            }
    })
}
    func exitVC(segueIdentifier:String){
           self.performSegue(withIdentifier: segueIdentifier, sender: self)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          //let vc = segue.destination as! YNResponse
          //vc.config = self.config
      }
}
