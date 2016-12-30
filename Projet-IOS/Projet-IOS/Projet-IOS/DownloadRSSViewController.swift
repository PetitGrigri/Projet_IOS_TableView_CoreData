//
//  DownloadRSSViewController.swift
//  Projet-IOS
//
//  Created by Fabien on 19/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//

import UIKit
import CoreData

class DownloadRSSViewController: UIViewController {

    @IBOutlet weak var progressionSpinner: UIActivityIndicatorView!
    @IBOutlet weak var labelProgression: UILabel!
    
    
    
    private let listeFluxRSS : [String] = ["http://korben.info/feed", "https://www.contrepoints.org/feed"]
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialisation du tabBarItem de ce controller (à faire pour chaque controller accessible via une tabBar pour le tunner ^^)
        self.tabBarItem = UITabBarItem(title: "Telecharger", image: UIImage(named: "download-7"), tag: 2)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //cette méthode est lancé à chaque fois que la UIViewController est affiché
    override func viewDidAppear(_ animated: Bool) {
        //lancement de l'animation
        progressionSpinner.hidesWhenStopped = true
        progressionSpinner.startAnimating()
        
        //indication du téléchargement en cours
        labelProgression.text = "Téléchargements des flux RSS en cours"
        
        //désactivation des items tabBar tant qu'on à pas terminé le téléchargement
        self.tabBarController!.tabBar.items![0].isEnabled = false
        self.tabBarController!.tabBar.items![1].isEnabled = false
        
        //réalisation du téléchargement des flux RSS en asynchrone
        DispatchQueue.global(qos: .background).async {
            
            if let context = DataManager.shared.objectContext {
                
                //récupération / affichage des itemsRSS
                let fetchRequest: NSFetchRequest  <ItemsRSS> = ItemsRSS.fetchRequest()
                
                //permet de connaitre le nombre d'itemsRSS et de les supprimer s'il y en a
                let countItemRSS = try? context.count(for: fetchRequest)
                print("Nombre d'itemRSS : \(countItemRSS!)")
                
                if countItemRSS! > 0 {
                    //labelProgression.text = "Suppression des anciens articles"
                    //suppression des itemsRSS
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
                    do {
                        try context.execute(deleteRequest)
                        try context.save()
                    } catch {
                        print (error)
                    }
                }
                
                
                //récupération / affichage des channelRSS
                let fetchRequestChannel: NSFetchRequest  <ChannelRSS> = ChannelRSS.fetchRequest()
                
                //permet de connaitre le nombre d'itemsRSS et de les supprimer s'il y en a
                let countChannelRSS = try? context.count(for: fetchRequestChannel)
                print("Nombre de ChannelRss : \(countChannelRSS!)")
                
                if countChannelRSS! > 0 {
                    //labelProgression.text = "Suppression des anciens articles"
                    //suppression des itemsRSS
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequestChannel as! NSFetchRequest<NSFetchRequestResult>)
                    do {
                        try context.execute(deleteRequest)
                        try context.save()
                    } catch {
                        print (error)
                    }
                }
                
                
                
                
                
                //on parcours la liste de nos flux RSS et on les parcourera ensuite, afin de les enregistrer Dans notre model ItemsRSS
                let parserRSSDelegate = RSSParserDelegate()
                
                for fluxRSS in self.listeFluxRSS {
                    
                    
                    if let urlFluxRSS = URL(string: fluxRSS) {
                        DispatchQueue.main.async {
                            self.labelProgression.text = "Téléchargement des vos flux RSS \n \(fluxRSS)"
                        }
                        if let myRSSParser = XMLParser(contentsOf: urlFluxRSS) {
                            
                            myRSSParser.delegate = parserRSSDelegate
                            myRSSParser.parse()
                            
                            for itemRSS in parserRSSDelegate.items {
                                //Ajout d'un itemRSS (commitStrip)
                                if let itemModel = NSEntityDescription.insertNewObject(forEntityName: "ItemsRSS", into: context) as? ItemsRSS {
                                    itemModel.title = itemRSS.title
                                    itemModel.link  = itemRSS.link
                                    itemModel.author = itemRSS.author
                                    itemModel.rss_description = itemRSS.rssDescription
                                    itemModel.category = itemRSS.description
                                    itemModel.comments = itemRSS.comments
                                    itemModel.pub_date = itemRSS.pubDate
                                    
                                    if !itemRSS.contentEncoded.isEmpty {
                                        if let contentENcodedUTF8 = itemRSS.contentEncoded.data(using: String.Encoding.utf8) {
                                            if let contentENcodedUTF8NSData = contentENcodedUTF8 as NSData! {
                                                 itemModel.content_encoded = contentENcodedUTF8NSData
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            if let channelRSS = NSEntityDescription.insertNewObject(forEntityName: "ChannelRSS", into: context) as? ChannelRSS {
                                channelRSS.title = parserRSSDelegate.channel.title
                                channelRSS.description_channel = parserRSSDelegate.channel.descriptionChannel
                                channelRSS.link = parserRSSDelegate.channel.link
                                
                                if !parserRSSDelegate.channel.urlImage.isEmpty {
                                    let imageTempo:UIImage = UIImage.donwloadURL(withString: parserRSSDelegate.channel.urlImage)
                                    channelRSS.image = UIImagePNGRepresentation(imageTempo) as NSData?

                                }
                            }
                            
                            print(parserRSSDelegate.channel)
                            parserRSSDelegate.channel = Channel()
                            parserRSSDelegate.items.removeAll()
                        }
                    }
                }
                
                //sauvegarde des items précédents
                do {
                    try context.save()
                    print("sauvegarde réalisée")
                } catch {
                    print("erreur de la sauvegarde de l'article")
                }
                
            }
            
            DispatchQueue.main.async {
                self.labelProgression.text = "Téléchargements des flux RSS terminé"
                self.progressionSpinner.stopAnimating()
                
                //activation des items tabBar :)
                self.tabBarController!.tabBar.items![0].isEnabled = true
                self.tabBarController!.tabBar.items![1].isEnabled = true
            }
            
        }
        

        
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
