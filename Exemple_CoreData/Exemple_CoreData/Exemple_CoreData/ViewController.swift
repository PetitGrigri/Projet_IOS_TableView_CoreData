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
            
            //récupération / affichage des itemsRSS
            let fetchRequest: NSFetchRequest  <ItemsRSS> = ItemsRSS.fetchRequest()
            
            //permet de connaitre le nombre d'itemsRSS
            let countItemRSS = try? context.count(for: fetchRequest)
            print("Nombre d'itemRSS : \(countItemRSS!)")
            
            if countItemRSS! > 0 {
                //suppression des itemsRSS
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
                do {
                    try context.execute(deleteRequest)
                    try context.save()
                    print("suppression des itemRSS réalisées")
                } catch {
                    print (error)
                }
            }
        
            //Ajout d'un itemRSS (commitStrip)
            if let item = NSEntityDescription.insertNewObject(forEntityName: "ItemsRSS", into: context) as? ItemsRSS {
                item.title = "commitstrip"
                item.author = "fan de strip"
                item.rss_description = "strip sur le monde IT"
                item.link = "http://www.commitstrip.com/fr/"
            }
            
            //Ajout d'un itemRSS (les joies du code)
            if let item = NSEntityDescription.insertNewObject(forEntityName: "ItemsRSS", into: context) as? ItemsRSS {
                item.title = "Les joies du code/"
                item.author = "pause café"
                item.rss_description = "images humoristiques sur le monde des développeur"
                item.link = "http://lesjoiesducode.fr/"
            }
            
            //sauvegarde des items précédents
            do {
                try context.save()
                print("sauvegarde réalisée")
            } catch {
                print("erreur de la sauvegarde de l'article")
            }
        
            
            if let rows = try? context.fetch(fetchRequest) {
                for i in rows {
                    print("Item RSS : \n  Title : \(i.title!) \n  Description : \(i.rss_description!) \n  Link : \(i.link!)")
                    
                    //context.delete pour supprimer (méthode lente)
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

