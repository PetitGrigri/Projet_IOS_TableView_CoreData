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

        var contenuArticle = article?.rss_description
        
        if article?.content_encoded != nil {
            if let dataContentEncoded = article?.content_encoded as Data! {
                if let tempoContenu = String.init(data: dataContentEncoded, encoding: String.Encoding.utf8) {
                    contenuArticle = tempoContenu
                }
            }
        }
        articleWebView.loadHTMLString(contenuArticle!, baseURL: nil)
        self.navigationItem.title = article?.title
    }

    @IBAction func shareButton(_ sender: Any) {
        
        let shareArticle = article?.title
        let exempleUrl = NSURL(string: (article?.link)!)
        
        let activityViewController = UIActivityViewController(activityItems: [shareArticle!,exempleUrl!],applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: {})
        
    }
}
