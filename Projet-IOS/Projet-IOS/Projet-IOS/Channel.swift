//
//  Channel.swift
//  Projet-IOS
//
//  Created by Fabien on 29/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//

import UIKit

/**
 * Abstraction d'un item d'un flux RSS
 * Cette classe se base sur les spécifications RSS des Channel de la W3C disponible à l'adresse :
 *     https://validator.w3.org/feed/docs/rss2.html
 */
class Channel: NSObject {

    //	The name of the channel
    var title:String="";
    
    //The URL to the HTML website corresponding to the channel.
    var link:String="";
    
    //Phrase or sentence describing the channel.
    var descriptionChannel:String="";
    
    //the URL of a GIF, JPEG or PNG image that represents the channel.
    var urlImage:String="";
    
    
    override var description: String {
        return "title : \n\(self.title) \nlink : \n\(self.link)  \ndescription : \n\(self.descriptionChannel) \nurlImage : \n\(self.urlImage)"
    }

}
