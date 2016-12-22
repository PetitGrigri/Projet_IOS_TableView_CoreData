//
//  BrowserViewController.swift
//  WebViewer
//
//  Created by Asif on 22/12/2016.
//  Copyright © 2016 Asif. All rights reserved.
//

// Tuto : https://www.youtube.com/watch?v=UFKBTiylaN4

import UIKit

class BrowserViewController: UIViewController {
    
    @IBOutlet weak var browserView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "http://www.lemonde.fr")
        let urlRequest = URLRequest(url: url!)
        browserView.loadRequest(urlRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
