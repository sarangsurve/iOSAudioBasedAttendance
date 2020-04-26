//
//  ViewController.swift
//  AttendanceChecker
//
//  Created by APPLE on 07/09/19.
//  Copyright © 2019 Sarang Surve. All rights reserved.
//

import UIKit
import ChirpConnect

class AttendanceCheckerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let username = ["sarang","shrutika","amey","waahid","arjun","raju","anish","tanuja","neeraja"]
    var statusArray = Array<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        statusArray = Array(repeating: false, count: username.count)
        let chirp: ChirpConnect = ChirpConnect(appKey: CHIRP_APP_KEY, andSecret: CHIRP_APP_SECRET)!
        
        if let err = chirp.setConfig(CHIRP_APP_CONFIG) {
            print("ChirpError (%@)", err.localizedDescription)
        } else {
            if let err = chirp.start() {
                print("ChirpError (%@)", err.localizedDescription)
            } else {
                print("Started ChirpSDK")
            }
        }
        
        if let err = chirp.start(in: ChirpAudioMode.send) {
            print("ChirpError (%@)", err.localizedDescription)
        } else {
            print("Started ChirpSDK")
        }
        
        chirp.receivedBlock = {
            (data : Data?, channel: UInt?) -> () in
            if data != nil {
                let identifier = String(data: data!, encoding: .ascii)
                print("Received \(identifier!)")
                var count = 0
                for name in self.username{
                    if name != identifier{
                        count += 1
                    }else{
                        self.statusArray[count] = true
                        self.tableView.reloadData()
                    }
                }
                return
            } else {
                print("ChirpError: Decode failed!")
                return
            }
        }
    }
}

extension AttendanceCheckerViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return username.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.nameLabel.text = username[indexPath.row]
        if statusArray[indexPath.row]{
            cell.statusImage.image = UIImage(named: "present.png")
        }else{
            cell.statusImage.image = UIImage(named: "absent.png")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
