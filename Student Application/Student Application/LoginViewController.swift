//
//  ViewController.swift
//  Student Application
//
//  Created by SarangSurve on 30/08/19.
//  Copyright © 2019 SarangSurve. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let username = ["shrutika","amey","waahid","sarang","arjun","raju","anish","tanuja"]
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = #colorLiteral(red: 0.4250171954, green: 0.8788375175, blue: 0.7142431827, alpha: 1)
        loginButton.layer.cornerRadius = 20
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        for name in username{
            if name == textField.text{
                let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "AttendanceMarkerViewController") as! AttendanceMarkerViewController
                viewcontroller.name = name
                textField.text = ""
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            }
        }
    }
    

}

