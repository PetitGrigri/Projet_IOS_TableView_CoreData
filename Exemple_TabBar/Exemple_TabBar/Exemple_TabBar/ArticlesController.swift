//
//  ArticlesController
//  Exemple_TabBar
//
//  Created by Fabien on 13/12/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import UIKit

class ArticlesController: UIViewController {
    
    //TODO COMPRENDRE A QUOI SERT CE NSCODER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        self.tabBarItem = UITabBarItem(title: "Articles", image: UIImage(named: "text-list-7"), tag: 2)
        self.tabBarItem.badgeColor = UIColor.red
        self.tabBarItem.badgeValue = "75"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DidLoad ArticlesController")
        // Do any additional setup after loading the view.
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
