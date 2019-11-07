//
//  ViewController2.swift
//  Questio
//
//  Created by Rahul Berry on 03/11/2019.
//  Copyright © 2019 rberry. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    var text:String = ""

    @IBOutlet weak var Animoji: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(text)
        self.Animoji.image = UIImage(named: self.text)
        //navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
