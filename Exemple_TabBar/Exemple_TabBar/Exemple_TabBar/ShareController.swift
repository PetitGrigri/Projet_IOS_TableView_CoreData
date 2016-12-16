//
//  ShareController
//  Exemple_TabBar
//
//  Created by Fabien on 15/12/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import UIKit

class ShareController: UIViewController {
    //TODO COMPRENDRE A QUOI SERT CE NSCODER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialisation du tabBarItem de ce controller (à faire pour chaque controller accessible via une tabBar pour le tunner ^^)
        self.tabBarItem = UITabBarItem(title: "Partager", image: UIImage(named: "share-7"), tag: 3)
        // désactiviation de l'item tant qu'on ne visualise pas un article
        self.tabBarItem.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          //juste un affichage print, ici c'est plus un exemple, le share étant lié à un article
        print("DidLoad shareController")
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
