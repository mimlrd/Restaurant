//
//  HelperColor.swift
//  Restaurant
//
//  Created by Mike Milord on 06/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import UIKit


extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func noir() -> UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    static func fourchetteGreen() -> UIColor {
        return UIColor(red: 153, green: 175, blue: 142, alpha: 1)
    }
    
    
}
