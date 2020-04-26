//
//  AttendanceMarkerViewController.swift
//  Student Application
//
//  Created by APPLE on 07/09/19.
//  Copyright © 2019 SarangSurve. All rights reserved.
//

import UIKit
import ChirpConnect

class AttendanceMarkerViewController: UIViewController {
    
    var name:String!
    @IBOutlet weak var nameLabel: UILabel!
    let chirp: ChirpConnect = ChirpConnect(appKey: CHIRP_APP_KEY, andSecret: CHIRP_APP_SECRET)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let err = chirp.setConfig(CHIRP_APP_CONFIG) {
            print("ChirpError (%@)", err.localizedDescription)
        } else {
            if let err = chirp.start() {
                print("ChirpError (%@)", err.localizedDescription)
            } else {
                print("Started ChirpSDK")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = name
    }
    
    @IBAction func markPresentButton(_ sender: Any) {
        let identifier: String = nameLabel.text!
        let payload: Data = identifier.data(using: .utf8)!
        if let err = chirp.send(payload) {
            print("ChirpError (%@)", err.localizedDescription)
        } else {
            print("Sent \(identifier)")
        }
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
