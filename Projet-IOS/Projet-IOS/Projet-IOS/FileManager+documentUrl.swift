//
//  FileManager.swift
//  MyCoreDataApplication
//
//  Created by Fabien on 16/11/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import Foundation

extension FileManager
{
    public static func documentURL() -> URL? {
        return self.documentURL(childPath: nil)
    }
    
    public static func documentURL(childPath: String?) -> URL? {
        if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            if let path = childPath {
                return documentURL.appendingPathComponent(path)
            }
            return documentURL
        }
        return nil
    }
    
    
    
    
}
