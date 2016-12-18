//
//  RSSXMLParser.swift
//  Exemple_RSS
//
//  Created by Fabien on 17/12/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import UIKit

class RSSXMLParserDelegate: NSObject, XMLParserDelegate {
    var items:[ItemRSS] = []
    var elementNameInProgress:String = ""

    
    public func parserDidStartDocument(_ parser: XMLParser) {
        print("Début du parsing")
    }
    
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        print("Fin du parsing")
    }
    
    
    public func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
        print("parser1")
    }
    
    
     public func parser(_ parser: XMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?){
        print("parser2")
    }
    
    
     public func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?){
        print("parser3")
    }
    
    
     public func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String){
        print("parser4")
    }
    
    
     public func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?){
        print("parser5")
    }

    
    
     public func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?){
        print("parser6")
    }

    
    /**
      * Cette méthode est appellée lorsqu'elle rencontre un nouvel élément XML
      */
     public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        
        switch elementName {
            case "item":    self.items.append(ItemRSS())
                            print("je viens d'ajouter un nouvel ItemRSS")
                            break
            
            default:        self.elementNameInProgress = elementName
                            print("Element en cours : \(self.elementNameInProgress)")
                            break
        }
        
        print("parser7 (didStartElement) ")
        print("   elementName : \(elementName)")
        print("   namespaceURI : \(namespaceURI)")
        print("   qualifiedName : \(qName)")
        print("   attributeDict : \(attributeDict)")
    }

    
    /**
     * Cette méthode est appellée lorsqu'elle rencontre la fin d'un élément XML
     *
     */
     public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        print("parser8 (didEndElement) ")
        print("   elementName : \(elementName)")
        print("   namespaceURI : \(namespaceURI)")
        print("   qName : \(qName)")
        
        self.elementNameInProgress = ""

    }

    
    
     public func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String){
        print("parser9")
    }

    
    
     public func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String){
        print("parser10")
    }

    
    /**
     * Cette méthode est appellée lorsqu'elle lit le contenu d'une balise XML
     * Juste avant le parser didStartElement aura été appellé ce qui permet de savoir ce qu'on lit
     * C'est méthode sera utilisé pour set les propriétés de l'ItemRSS qui aura été ajouté dans items
     */
     public func parser(_ parser: XMLParser, foundCharacters string: String){
        switch self.elementNameInProgress {
            case "title":
                items.last?.title.append(string)
                break
            case "link":
                items.last?.link.append(string)
                break
            case "description":
                items.last?.content.append(string)
                break
            case "author":
                items.last?.author.append(string)
                break
            case "category":
                items.last?.category.append(string)
                break
            case "comments":
                items.last?.comments.append(string)
                break
            case "enclosure":
                items.last?.enclosure.append(string)
                break
            case "guid":
                items.last?.guid.append(string)
                break
            case "pubDate":
                items.last?.pubDate.append(string)
                break
            case "source":
                items.last?.source.append(string)
                break
            default:        break
            
        }
        
        print("parser11 (foundCharacters) ")
        print("   string (\(self.elementNameInProgress)): \(string)")
    }

    
    
     public func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String){
        print("parser12")
    }

    
    
     public func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?){
        print("parser13")
    }

    
    
     public func parser(_ parser: XMLParser, foundComment comment: String){
        print("parser14")
    }

    
    
     public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data){
        print("parser15 (foundCDATA) ")
        print("   elementName : \(CDATABlock)")

    }

    
    
    //optional public func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data?
    
    
     public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error){
        print("parser16")
    }

    
    
     public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error){
        print("parser17")
    }


}
