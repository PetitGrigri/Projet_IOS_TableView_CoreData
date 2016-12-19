//
//  DownloadRSSViewController.swift
//  Projet-IOS
//
//  Created by Fabien on 19/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//


import UIKit

class ListArticlesViewController: UITableViewController {
    
    //variable contenant des fruits
    private  var articles = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
                           "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
                           "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
                           "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
                           "Pear", "Pineapple", "Raspberry", "Strawberry"]
    
    
    
    //TODO COMPRENDRE A QUOI SERT CE NSCODER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialisation du tabBarItem de ce controller (à faire pour chaque controller accessible via une tabBar pour le tunner ^^)
        self.tabBarItem = UITabBarItem(title: "Vos articles", image: UIImage(named: "list-simple-7"), tag: 0)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Méthode indiquant le nombre de section de notre table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Méthode indiquant le nombre de fruit pour la section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    //Méthode permettant de créer ou de renvoyer une cellule
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //récupération de notre cellule (cette dernière se trouve dans notre story board avec l'identifiant labelCell
        //si on avait pas fait comme ca on aurait du (sauf erreur créer à la main notre cellule)
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        
        //récupération du nom du fuit à afficher
        let fruitName = articles[indexPath.row]
        
        //remplissage du texte du fruit ainsi que du sous titre
        cell.detailTextLabel?.text = "Delicious!"
        cell.textLabel?.text = fruitName
        
        
        
        //on set ici l'image (si cette image existe (ici les images se trouve dans le dossier Assets.xcassets)
        if let imageFruit = UIImage(named: fruitName) {
            cell.imageView?.image = imageFruit                                  //on set l'image
            cell.imageView?.frame = CGRect(x:0.0,y:0.0,width:40.0,height:40.0)  //on set la taille de l'image
            cell.imageView?.layer.cornerRadius = 22                             //on affiche l'image dans un frame "ronde"
            cell.imageView?.clipsToBounds = true                                //on coupe l'image qui dépasse de cette frame
            cell.imageView?.layer.borderWidth = 2                               //taille de la bordure
            cell.imageView?.layer.borderColor = UIColor.init(red: 0.95, green: 0.95, blue: 1, alpha: 1).cgColor //couleur de la bordure
        }
        
        //retour de la cellule
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "articles (section \(section + 1))"
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
