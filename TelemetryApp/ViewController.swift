//
//  ViewController.swift
//  TelemetryApp
//
//  Created by Nagarjuna Madamanchi on 12/10/2017.
//  Copyright © 2017 Nagarjuna Group Ltd. All rights reserved.
//

import UIKit
//import UDPBroadcast

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    var broadcastConnection: UDPBroadcastConnection!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        broadcastConnection = UDPBroadcastConnection(port: Config.Ports.broadcast) { [unowned self] (ipAddress: String, port: Int, response: [UInt8]) -> Void in
            let log = "Received from \(ipAddress):\(port):\n\n\(response)"
            let decData = NSData(bytes: response, length: Int(response.count))
            let decodedString = NSString(data: decData as Data, encoding: String.Encoding.utf8.rawValue)
            
            print(decodedString)
            self.textView.text = log
        }
    }

    @IBAction func submitAction(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reload(_ sender: AnyObject) {
        self.textView.text = ""
        broadcastConnection.sendBroadcast(Config.Strings.broadcastMessage)
    }

}

