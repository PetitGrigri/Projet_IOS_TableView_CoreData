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
  * Cette classe se base sur les spécifications RSS des Items de la W3C disponible à l'adresse : 
  *     https://validator.w3.org/feed/docs/rss2.html
  * les informations sur content:encoded peuvent être trouvées ici : 
  *     http://www.rssboard.org/rss-profile#namespace-elements-content-encoded
  */
class ItemRSS : NSObject{
    
    //The title of the item.
    var title:String = ""
    
    //The URL of the item.
    var link:String  = ""
    
    //The item synopsis. (dans  le flux rss ce sera "description" mais pour éviter les conflits on change le nom de la variable
    var rssDescription:String  = ""
    
    //Email address of the author of the item. More.
    var author:String  = ""
    
    //Includes the item in one or more categories. More.
    var category:[String]  = []
    
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
    
    //The content:encoded element defines the full content of an item
    var contentEncoded : String = ""
    
    
    public func addCategory(categoryName: String){
        self.category.append(categoryName)
    }
    
    
    
    
    override var description: String {
        var tempo:String = ""
        
        for cat in self.category {
            if !tempo.isEmpty {
                tempo.append(", ")
            }
            tempo.append(cat)
        }

        return "title : \n\(self.title) \nlink : \n\(self.link) \ncontent : \n\(self.rssDescription) \nauthor : \n\(self.author) \ncategory : \n\(tempo) \ncomments : \n\(self.comments) \nenclosure : \n\(self.enclosure) \nguid : \n\(self.guid) \npubDate : \n\(self.pubDate) \nsource : \n\(self.source) \ncontentEncoded : \n\(contentEncoded)"
    }
    
}
