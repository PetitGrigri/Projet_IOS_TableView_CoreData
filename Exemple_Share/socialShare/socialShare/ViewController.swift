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
        
        // exemple data
        let exempleArticle = "Fin attendue du pic de pollution en région parisienne dimanche. En savoir plus sur www.lemonde.fr"
        let exempleImage = UIImage(named: "pic_pol.jpg")
        
        let shareActionSheet = UIAlertController(title: nil, message: "Share with", preferredStyle: .actionSheet)
        
        // twitter share
        let twitterShareAction = UIAlertAction(title: "Twitter", style: .default, handler: {(action) -> Void in
            
            // show twitter composer
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                
                // Twitter account ok
                
                let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                // attention : 140 characters max
                tweetComposer?.setInitialText(exempleArticle)
                tweetComposer?.add(exempleImage)

                self.present(tweetComposer!, animated: true, completion: nil)
                
            } else{
                
                // Twitter account error (pas connecté)
                
                self.alertDialog(title: "Twitter error", msg: "Verifier votre connection twitter")
            }
            
        })
        
    
        
        // facebook share
        let facebookShareAction = UIAlertAction(title: "Facebook", style: .default, handler: {(action) -> Void in
            
            // show facebook composer
            
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                
                // Facebook account ok
                
                let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                // share data (text, image ...)
                
                facebookComposer?.setInitialText(exempleArticle)
                facebookComposer?.add(exempleImage)
                
                self.present(facebookComposer!, animated: true, completion: nil)
                
            } else{
                
                // Facebook account error (pas connecté)
                
                self.alertDialog(title: "Facebook error", msg: "Verifier votre connection facebook")
            }
            
        })

        
        shareActionSheet.addAction(twitterShareAction)
        shareActionSheet.addAction(facebookShareAction)
        
        self.present(shareActionSheet, animated: true, completion: nil)
        
    }
    
    // Fonction permet d'afficher une alert
    func alertDialog(title: String, msg: String){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        // button reglage => affiche reglage
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { action in
            
            UIApplication.shared.open(NSURL(string: UIApplicationOpenSettingsURLString) as! URL, options: [:],completionHandler: nil)
            
        }
        
        alertController.addAction(settingsAction)
        
        // button ok
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
