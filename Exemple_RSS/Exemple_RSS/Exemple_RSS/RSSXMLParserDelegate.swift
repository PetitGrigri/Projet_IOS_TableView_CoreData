//
//  RSSXMLParser.swift
//  Exemple_RSS
//
//  Created by Fabien on 17/12/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import UIKit

/**
  * Un Delegate de Parser XML qui a pour but de parcourir un document RSS
  *
  *
  */
class RSSXMLParserDelegate: NSObject, XMLParserDelegate {
    
    //une liste d'itemRSS
    var items:[ItemRSS] = []
    
    //une variable contenant l'élément XML de notre flux RSS en train d'être lu (la lecture de l'élément puis de son contenu se fait en deux étapes)
    private var elementNameInProgress:String = ""
    
    //une variable contenant le contenu de l'élément en cours de lecture
    private var tempoRead:String = ""

    
    /**
      * Cette méthode est appellée lorsqu'elle rencontre un nouvel élément XML.
      * Lorsque cette méthode rencontrera un elementName "item", elle ajoutera un nouvel itemRSS dans items
      * Dans tout les cas on mémorisera l'élément en cours de "lecture"
      */
     public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        
        //print("didStartElement : \(elementName)")
        
        switch elementName {
            case "item":
                self.items.append(ItemRSS())
            
            default:
                self.elementNameInProgress = elementName
                
                break
        }
    }

    
    /**
     * Cette méthode est appellée lorsqu'elle rencontre la fin d'un élément XML
     * Elle permet de vider la mémorisation de l'élément en cours et de ne pas le remplir avec des données fausses
     */
     public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        //print("didEndElement : \(elementName)")
        
       // tempoRead = String(tempoRead.characters.filter { !"\n\t\r".characters.contains($0) })
        tempoRead = tempoRead.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        setLastItem()
        self.elementNameInProgress = ""
        self.tempoRead = ""

    }

    
    
    /**
     * Cette méthode est appellée lorsqu'elle lit le contenu d'une balise XML
     * Juste avant, le parser didStartElement aura été appellé pour enregistrer dans elementNameInProgress l'élément XML en cours
     * C'est méthode sera utilisé pour "setter" les propriétés de l'ItemRSS qui aura été ajouté dans items
     */
    public func parser(_ parser: XMLParser, foundCharacters string: String){
        //print("foundCharacters")
        
        self.tempoRead.append(string)

       

    }
    
    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data){
        //print("foundCDATA")
        
        if let tempo = String.init(data: CDATABlock, encoding: .utf8) {
            //print("   tempo : \(tempo)")
            self.tempoRead.append(tempo)
        }
    }
    
    
    
    private func setLastItem() {
        

        
        switch self.elementNameInProgress {
            case "title":
                items.last?.title.append(self.tempoRead)
                break
            case "link":
                items.last?.link.append(self.tempoRead)
                break
            case "description":
                items.last?.rssDescription.append(self.tempoRead)
                break
            case "author":
                items.last?.author.append(self.tempoRead)
                break
            case "category":
                items.last?.addCategory(categoryName: self.tempoRead)
                break
            case "comments":
                items.last?.comments.append(self.tempoRead)
                break
            case "enclosure":
                items.last?.enclosure.append(self.tempoRead)
                break
            case "guid":
                items.last?.guid.append(self.tempoRead)
                break
            case "pubDate":
                items.last?.pubDate.append(self.tempoRead)
                break
            case "source":
                items.last?.source.append(self.tempoRead)
                break
            case "content:encoded":
                items.last?.contentEncoded.append(self.tempoRead)
            default:
                break
            
        }
    }
    
    /*
    
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        print("Début du parsing du document XML")
    }
    
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        print("Fin du parsing du document XML")
    }
    
    
    public func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
        print("foundNotationDeclarationWithName")
    }
    
    
    public func parser(_ parser: XMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?){
        print("foundUnparsedEntityDeclarationWithName")
    }
    
    
    public func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?){
        print("foundAttributeDeclarationWithName")
    }
    
    
    public func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String){
        print("foundElementDeclarationWithName")
    }
    
    
    public func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?){
        print("foundInternalEntityDeclarationWithName")
    }
    
    
    
    public func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?){
        print("foundExternalEntityDeclarationWithName")
    }
    

    
     public func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String){
        print("didStartMappingPrefix")
    }

    
    
     public func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String){
        print("didEndMappingPrefix")
    }

 


    
    
     public func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String){
        print("foundIgnorableWhitespace")
    }

    
    
     public func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?){
        print("foundProcessingInstructionWithTarget")
    }

    
    
     public func parser(_ parser: XMLParser, foundComment comment: String){
        print("foundComment")
    }

    
    
     public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error){
     print("parseErrorOccurred")
     }
     
     
     
     public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error){
     print("validationErrorOccurred")
     }
 */
    
    
    //optional public func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data?
    
    


    
    
}
