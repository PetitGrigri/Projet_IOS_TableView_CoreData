//
//  ViewController.swift
//  Exemple_CoreData
//
//  Created by Fabien on 20/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    private let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let context = dataManager.objectContext {
            
            //création d'un itemsRSS
            /* //le faire qu'une fois (histoire d'insérer un enregistrement
            if let item = NSEntityDescription.insertNewObject(forEntityName: "ItemsRSS", into: context) as? ItemsRSS {
                item.title = "commitstrip"
                item.author = "fan de strip"
                item.rss_description = "strip sur le monde IT"
                item.link = "http://www.commitstrip.com/fr/"
             
            }*/
            
            //récupération / affichage des itemsRSS
            let fetchRequest: NSFetchRequest <ItemsRSS> = ItemsRSS.fetchRequest()
            
            if let rows = try? context.fetch(fetchRequest) {
                for i in rows {
                    print("Item RSS : \n  Title : \(i.title!) \n  Description : \(i.rss_description!) \n  Link : \(i.link!)")
                    
                    //context.delete pour supprimer
                }
            }
            
            
            /*
             //réalisation d'une sauvegarde
             do {
                try context.save()
                print("sauvegarde réalisée")
            } catch {
                print("erreur de la sauvegarde de l'article")
            }*/
            
        }
            
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

