//
//  ViewController.swift
//  socialShare
//
//  Created by Asif on 13/12/2016.
//  Copyright © 2016 Asif. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareButton(_ sender: Any) {
        
        let shareActionSheet = UIAlertController(title: nil, message: "Share with", preferredStyle: .actionSheet)
        
        let twitterShareAction = UIAlertAction(title: "Twitter", style: .default, handler: {(action) -> Void in
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                tweetComposer?.setInitialText("Test !");
            }
            
        })
        
    }

}

