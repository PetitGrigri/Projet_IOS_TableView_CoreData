//
//  DownloadRSSViewController.swift
//  Projet-IOS
//
//  Created by Fabien on 19/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//


import UIKit
import CoreData

class ListArticlesViewController: UITableViewController {

    
    @IBOutlet weak var labelNoArticle: UILabel!
    //variable contenant des articles
    
    private  var articles:[ItemsRSS] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialisation du tabBarItem de ce controller (à faire pour chaque controller accessible via une tabBar pour le tunner ^^)
        self.tabBarItem = UITabBarItem(title: "Vos articles", image: UIImage(named: "list-simple-7"), tag: 0)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let context = DataManager.shared.objectContext {
            
            //récupération / affichage des itemsRSS
            let fetchRequest: NSFetchRequest  <ItemsRSS> = ItemsRSS.fetchRequest()
            
            let fetchRequestOrder = NSSortDescriptor.init(key: "pub_date", ascending: false)
            fetchRequest.sortDescriptors = [fetchRequestOrder]
            
            if let rows = try? context.fetch(fetchRequest) {
                articles = []
                for item in rows {
                    articles.append(item)
                }
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    //Méthode indiquant le nombre de section de notre table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     */
    
    //Méthode indiquant le nombre de fruit pour la section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (self.articles.count > 0) {
            labelNoArticle.isHidden = true
        } else {
            labelNoArticle.isHidden = false
        }
        return self.articles.count
    }
    
    //Méthode permettant de créer ou de renvoyer une cellule
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //récupération de notre cellule (cette dernière se trouve dans notre story board avec l'identifiant labelCell
        //si on avait pas fait comme ca on aurait du (sauf erreur créer à la main notre cellule)
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        
        //récupération du nom du fuit à afficher
        let article = articles[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // les pubdate sont au format RFF 882

        //remplissage du texte du fruit ainsi que du sous titre
        cell.textLabel?.text = article.title
        if let descriptionRSS = article.rss_description {
             cell.detailTextLabel?.text = "\(formatter.string(from: article.pub_date as! Date)) \(descriptionRSS.htmlToString() )"
        } else{
            cell.detailTextLabel?.text = formatter.string(from: article.pub_date as! Date)
        }
       
        
        //retour de la cellule
        return cell
    }

    
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        print(sender.debugDescription)
        
        if (segue.identifier == "showArticleSegue") {
            if let indexSelectedRow = self.tableView.indexPathForSelectedRow {
                let articleViewController = segue.destination as! ArticleViewController
                
                articleViewController.article = articles[indexSelectedRow.row]
            }
        }
        
     }
    
    
}
