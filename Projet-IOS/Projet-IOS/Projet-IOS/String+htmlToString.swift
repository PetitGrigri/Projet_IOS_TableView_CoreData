//
//  File.swift
//  Projet-IOS
//
//  Created by Fabien on 29/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//

import UIKit

extension String {
    public  func htmlToString() -> String{
        if let dataFromString:Data = self.data(using: String.Encoding.utf8) {
            
            do {
                let attributedString:NSAttributedString = try NSAttributedString(data: dataFromString, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
                return attributedString.string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            } catch {
                return self
            }
            
            
        }
        
        return self
    }
}
