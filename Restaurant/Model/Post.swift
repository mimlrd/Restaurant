//
//  Post.swift
//  Restaurant
//
//  Created by Mike Milord on 05/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import UIKit


class Post: NSObject {
    
    var image: UIImage
    var name: String
    var address: String
    var bio: String
    var type: String
    
    
    init(image: UIImage, name: String, address: String, bio: String, type: String) {
        self.image = image
        self.name = name
        self.address = address
        self.bio = bio
        self.type = type
    }
    
}
