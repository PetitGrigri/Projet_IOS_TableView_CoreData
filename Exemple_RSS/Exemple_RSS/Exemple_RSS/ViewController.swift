//
//  ViewController.swift
//  Exemple_RSS
//
//  Created by Fabien on 16/12/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate{

    var listeFluxRSS : [String] = ["http://www.lemonde.fr/m-actu/rss_full.xml", "https://www.contrepoints.org/feed"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for fluxRSS in listeFluxRSS {
            //print("url actuelle : \(fluxRSS) \n")
            if let urlFluxRSS = URL(string: fluxRSS) {

                //affichage du flux rss distant (on ne l'utilisera pas, on s'en sert juste pour le débug)
                /*if let contentURL = try? String.init(contentsOf: urlFluxRSS) {
                    print ("Début du contenu du flux RSS : \n\(contentURL.substring(to: contentURL.index(contentURL.startIndex, offsetBy: 300)))...\n");
                }*/
                
                if let myRSSParser = XMLParser(contentsOf: urlFluxRSS) {
                    let parserRSSDelegate = RSSXMLParserDelegate()
                    myRSSParser.delegate = parserRSSDelegate
                    myRSSParser.parse()
                    
                    for item in parserRSSDelegate.items {
                        print("\n\n\(item.description)")
                    }
                }
            }
        }
        
        

        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
   
}

