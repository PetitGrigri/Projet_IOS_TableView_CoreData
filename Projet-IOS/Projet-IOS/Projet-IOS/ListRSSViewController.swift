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
    
    
    //Méthode indiquant le nombre de fruit pour la section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }
    
    //Méthode permettant de créer ou de renvoyer une cellule
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //récupération de notre cellule (cette dernière se trouve dans notre story board avec l'identifiant labelCell
        //si on avait pas fait comme ca on aurait du (sauf erreur créer à la main notre cellule)
        let cell = tableView.dequeueReusableCell(withIdentifier: "rssCell", for: indexPath)
        
        //si on n'a pas encore télécharger le contenu de notre fluxRSS on affiche l'url et un message informatif

        if (channels[indexPath.row].title == nil) {
            cell.textLabel?.text = channels[indexPath.row].url_feed
            cell.detailTextLabel?.text = "Aucun téléchargement fait pour ce flux RSS"
        } else {
            cell.textLabel?.text = channels[indexPath.row].title
            cell.detailTextLabel?.text = channels[indexPath.row].description_channel
        }
        
        
        if let tempoData:NSData = channels[indexPath.row].image {
            cell.imageView?.image = UIImage.init(data: tempoData as Data!)
        } else
        {
            cell.imageView?.image = nil;
        }
        
        
        //retour de la cellule
        return cell
    }
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
 
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
            
            let fetchRequestOrder = NSSortDescriptor.init(key: "title", ascending: false)
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
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
