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
        
        // Initialize Tab Bar Item
        self.tabBarItem = UITabBarItem(title: "Partager", image: UIImage(named: "share-7"), tag: 3)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DidLoad shareController")
        
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
