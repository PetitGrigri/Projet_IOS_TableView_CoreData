//
//  DownloadRSSViewController.swift
//  Projet-IOS
//
//  Created by Fabien on 19/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//


import UIKit
import CoreData

class ListRSSViewController: UITableViewController {
    

    @IBOutlet weak var labelNoChannelRSS: UILabel!
    //variable contenant les informations du channel de nos flux RSS
    private  var channels:[ChannelRSS] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialisation du tabBarItem de ce controller (à faire pour chaque controller accessible via une tabBar pour le tunner ^^)
        self.tabBarItem = UITabBarItem(title: "Vos flux RSS", image: UIImage(named: "rss-7"), tag: 1)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Méthode indiquant le nombre de fluxRSS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.channels.count > 0) {
            labelNoChannelRSS.isHidden = true
        } else {
            labelNoChannelRSS.isHidden = false
        }
        return self.channels.count
    }
    
    //Méthode permettant de créer ou de renvoyer une cellule
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //récupération de notre cellule (cette dernière se trouve dans notre story board avec l'identifiant labelCell
        //si on avait pas fait comme ca on aurait du (sauf erreur créer à la main notre cellule)
        let cell = tableView.dequeueReusableCell(withIdentifier: "rssCell", for: indexPath)
        
        //si on n'a pas encore téléchargé le contenu de notre fluxRSS (ou si l'url n'est pas bonne) on affiche l'url et un message informatif
        if (channels[indexPath.row].title == nil) || (channels[indexPath.row].title!.isEmpty) {
            cell.textLabel?.text = channels[indexPath.row].url_feed
            cell.detailTextLabel?.text = "Aucun téléchargement fait pour ce flux RSS"
        } else {
            cell.textLabel?.text = channels[indexPath.row].title
            cell.detailTextLabel?.text = channels[indexPath.row].description_channel
        }
        
        //si on a une image enregistrée
        if let tempoData:NSData = channels[indexPath.row].image {
            cell.imageView?.image = UIImage.init(data: tempoData as Data!)
        } else
        {
            cell.imageView?.image = nil;
        }
        
        
        //retour de la cellule
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
    */
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {

            if let context = DataManager.shared.objectContext {
                context.delete(channels[indexPath.row])
                channels.remove(at: indexPath.row)
                do {
                    try context.save()
                    print ("suppression du flux RSS réalisée")
                } catch {
                    print("erreur lors de la suppression du flux RSS")
                }
                // Delete the row from the data source
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
         }
    }
    
    @IBAction func addFluxRssButton(_ sender: Any) {
        // ajouter source flux rss
        let addRssPopUp = UIAlertController(title: "Ajouter un flux rss", message: nil, preferredStyle: .alert)

        // edit text field
        addRssPopUp.addTextField(configurationHandler: {(mTextF) in
            mTextF.placeholder = "Ex : http://korben.info/feed"
        })
        
        // button ok
        addRssPopUp.addAction(UIAlertAction(title: "Ajouter", style: .default, handler: {(_) in
            
            if let fluxRssUrl = addRssPopUp.textFields?[0] {

                if (!fluxRssUrl.text!.isEmpty) {
                    
                    if let context = DataManager.shared.objectContext {
                        if let channelRSS = NSEntityDescription.insertNewObject(forEntityName: "ChannelRSS", into: context) as? ChannelRSS {
                            channelRSS.url_feed = fluxRssUrl.text!

                            do {
                                try context.save()
                                print("sauvegarde réalisée")
                                self.loadChannel()
                            } catch {
                                print("erreur de la sauvegarde du fluxRSS")
                            }

                        }

                    }
                }
            }
            
        }))
        
        // button annuler
        addRssPopUp.addAction(UIAlertAction(title: "Annuler", style: .default, handler: nil))
        
        self.present(addRssPopUp, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadChannel()
    }
    
    
    
    
    private func loadChannel() {
        if let context = DataManager.shared.objectContext {
            
            //récupération / affichage des itemsRSS
            let fetchRequest: NSFetchRequest  <ChannelRSS> = ChannelRSS.fetchRequest()
            
            let fetchRequestOrder = NSSortDescriptor.init(key: "title", ascending: true)
            fetchRequest.sortDescriptors = [fetchRequestOrder]
            
            if let rows = try? context.fetch(fetchRequest) {
                channels = []
                for channel in rows {
                    channels.append(channel)
                }
                self.tableView.reloadData()
            }
            
        }
    }    
}
