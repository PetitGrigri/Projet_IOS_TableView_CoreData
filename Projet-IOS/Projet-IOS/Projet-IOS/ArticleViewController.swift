//
//  ArticleViewController.swift
//  Projet-IOS
//
//  Created by Fabien on 23/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article:ItemsRSS?
    
    @IBOutlet weak var articleWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        print(article!)
        articleWebView.loadHTMLString((article?.rss_description)!, baseURL: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
