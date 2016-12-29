//
//  UIImage+downloadUrl.swift
//  Projet-IOS
//
//  Created by Fabien on 27/12/2016.
//  Copyright © 2016 com.esgi.4amoc1. All rights reserved.
//

import UIKit
import Foundation

extension UIImage {
    public static func donwloadURL(withString:String ) -> UIImage{
        if let url = URL.init(string: withString) {
            let data = try? Data.init(contentsOf: url)
            return UIImage.init(data: data!)!
        }
        return UIImage.init()
    }
}
