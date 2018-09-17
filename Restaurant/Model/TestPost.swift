//
//  TestPost.swift
//  Restaurant
//
//  Created by Mike Milord on 05/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import UIKit


class SetPosts: NSObject {
    
    // Test Post
    
    func createPostsForTesting() -> [Post]{
        
        let italian_resto = Post(image: #imageLiteral(resourceName: "italian"), name: "Pastamore", address: "37 Boulevard du Montparnasse 75006 Paris", bio: "Aaaaah, les pâtes ! Avec une sauce, en gratin, en accompagnement ou en plat principal, rares sont ceux qui leur résistent. Faites-vous plaisir et aller déguster un bon plat dans un restaurant italien à Paris. ", type: "Italien")
        
        let creole_resto: Post = Post(image: #imageLiteral(resourceName: "creole"), name: "Muss & Turners - Smyrna", address: "17 Road Turner 75003 Paris", bio: "Un restaurant familliale ou va aller bien manger", type: "Français")
        
        let french_resto: Post = Post(image: #imageLiteral(resourceName: "french"), name: "A l'Endroit", address: "9, rue du Tunnel 75019 Paris", bio: "Au pied d’un des plus beaux espaces verts de Paris, le Parc des Buttes-Chaumont, et caché aux abords du délassant Square Botzaris, ce restaurant fait figure d’écrin de douceur et de bonne bouffe dans un quartier peu fourni en bonnes adresses.", type: "Français")
        
        let indian_resto: Post = Post(image: #imageLiteral(resourceName: "indian-kasmir"), name: "Le Maharajah", address: "2 rue Phillipe de Dangeau", bio: "Un restaurant indien comme vous ne l'avez jamais vu. Les repas sont tous délicieux", type: "Indien Kashmir")
        
        let spanish_resto: Post = Post(image: #imageLiteral(resourceName: "spanish"), name: "La Pirada", address: "7, rue de Lappe 75011 Paris", bio: "Un restaurant espagnol ou on mange mbien, miam!", type: "espagnol")
        
        
        return [italian_resto, creole_resto, french_resto, indian_resto, spanish_resto]
        
        
    }
}
