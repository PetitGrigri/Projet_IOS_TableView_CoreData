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

    private var formatter:DateFormatter
    
    required init?(coder aDecoder: NSCoder) {
        //configuration de notre DateFormater (qui sera utiliser pour interpréter les dates des flux rss)
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z" // les pubdate sont au format RFF 882
        
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
                
                /*
                 * Première étape : on vide  les articles qui sont enregistrés
                 */
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
                
                //pour chaque fluxRSS Disponibles
                if let rows = try? context.fetch(fetchRequestChannel) {
                    for channelRSS in rows {

                        //nous allors maitenant parcourir le contenu de nos flux RSS. Pour cela, nous utiliserons un XMLParser 
                        //TODO le sortir de la boucle ! !
                        let parserRSSDelegate = RSSParserDelegate()

                        
                        //pour chaque url de nos "channels"
                        if let urlFluxRSS = URL(string: channelRSS.url_feed!) {
                            DispatchQueue.main.async {
                                self.labelProgression.text = "Téléchargement des vos flux RSS \n \(channelRSS.url_feed!)"
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
                                        

                                        
                                        itemModel.pub_date =  self.formatter.date(from: itemRSS.pubDate) as NSDate?
                                        
                                        if !itemRSS.contentEncoded.isEmpty {
                                            if let contentENcodedUTF8 = itemRSS.contentEncoded.data(using: String.Encoding.utf8) {
                                                if let contentENcodedUTF8NSData = contentENcodedUTF8 as NSData! {
                                                    itemModel.content_encoded = contentENcodedUTF8NSData
                                                }
                                            }
                                        }
                                    }
                                }

                                channelRSS.title = parserRSSDelegate.channel.title
                                channelRSS.description_channel = parserRSSDelegate.channel.descriptionChannel
                                channelRSS.link = parserRSSDelegate.channel.link

                                
                                if !parserRSSDelegate.channel.urlImage.isEmpty {
                                    let imageTempo:UIImage = UIImage.donwloadURL(withString: parserRSSDelegate.channel.urlImage)
                                    channelRSS.image = UIImagePNGRepresentation(imageTempo) as NSData?
                                    
                                }

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
