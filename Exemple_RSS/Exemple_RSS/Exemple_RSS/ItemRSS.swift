//
//  Item.swift
//  Exemple_RSS
//
//  Created by Fabien on 17/12/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import UIKit

/**
  * Abstraction d'un item d'un flux RSS
  * Cette classe se base sur les spécifications RSS de la W3C disponible à l'adresse : https://validator.w3.org/feed/docs/rss2.html
  */
class ItemRSS : NSObject{
    
    //The title of the item.
    var title:String = ""
    
    //The URL of the item.
    var link:String  = ""
    
    //The item synopsis. (dans  le flux rss ce sera "description" mais pour éviter les conflits on change le nom de la variable
    var content:String  = ""
    
    //Email address of the author of the item. More.
    var author:String  = ""
    
    //Includes the item in one or more categories. More.
    var category:String  = ""
    
    //URL of a page for comments relating to the item. More.
    var comments:String  = ""
    
    //Describes a media object that is attached to the item. More.
    var enclosure:String  = ""
    
    //A string that uniquely identifies the item. More.
    var guid:String  = ""
    
    //Indicates when the item was published. More.
    var pubDate:String  = ""
    
    //The RSS channel that the item came from. More.
    var source : String  = ""
    
    override var description: String {
        return "title : \(self.title) \n link : \(self.link) \n content : \(self.content) \n author : \(self.author) \n category : \(self.category) \n comments : \(self.comments) \n enclosure : \(self.enclosure) \n guid : \(self.guid) \n pubDate : \(self.pubDate) \n source : \(self.source) "
    }
    
}
