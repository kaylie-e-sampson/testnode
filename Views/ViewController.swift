//
//  ViewController.swift
//
//  Created by Kaylie Sampson 10/5/20
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


class ViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func linkCDC(){
        UIApplication.shared.open(URL(string: "https://www.cdc.gov/coronavirus/2019-ncov/index.html?CDC_AA_refVal=https%3A%2F%2Fwww.cdc.gov%2Fcoronavirus%2Findex.html")! as URL)
    }
    func linkWHO(){
        UIApplication.shared.open(URL(string: "https://www.who.int/health-topics/coronavirus")! as URL)
    }
    func linkWMD(){
        UIApplication.shared.open(URL(string: "https://www.webmd.com/lung/coronavirus")! as URL)
    }
    func linkJHMap(){
        UIApplication.shared.open(URL(string: "https://coronavirus.jhu.edu/map.html")! as URL)
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["kksamps2@gmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
        }
        else {
            
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
