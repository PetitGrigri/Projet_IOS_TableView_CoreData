//
//  ArticlesController
//  Exemple_TabBar
//
//  Created by Fabien on 13/12/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import UIKit

class ArticlesController: UIViewController {
    
    //TODO COMPRENDRE A QUOI SERT CE NSCODER (mis ici par défaut)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialisation du tabBarItem de ce controller (à faire pour chaque controller accessible via une tabBar pour le tunner ^^)
        self.tabBarItem = UITabBarItem(title: "Articles", image: UIImage(named: "text-list-7"), tag: 2)
        self.tabBarItem.badgeColor = UIColor.red
        self.tabBarItem.badgeValue = "75"
        
    }
    
    //cette méthode n'est lancée qu'une fois dans le cycle de vie du UIViewController (lors de son chargement en mémoire)
    override func viewDidLoad() {
        super.viewDidLoad()
                print("DidLoad ArticlesController")
        
        //activation du partage quand on regarde un article
        self.tabBarController!.tabBar.items![2].isEnabled = true
    }
    
    //cette méthode est lancé à chaque fois que la UIViewController est affiché
    override func viewDidAppear(_ animated: Bool) {
        //petit print de débug
        print("DidLoad ArticlesController viewDidAppear")
        
        //désactivation du partage quand on regarde un article
        self.tabBarController!.tabBar.items![2].isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
