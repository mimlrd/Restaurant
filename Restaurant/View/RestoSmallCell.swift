//
//  RestoSmallCell.swift
//  Restaurant
//
//  Created by Mike Milord on 06/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import UIKit

class RestoSmallCell: UICollectionViewCell {
    
    @IBOutlet weak var restoImageView: UIImageView!
    @IBOutlet weak var restoNameLbl: UILabel!
    @IBOutlet weak var restoTypeLbl: UILabel!
    
    
    @IBOutlet weak var cookingScroreLbl: UILabel!
    
    @IBOutlet weak var serviceScoreLbl: UILabel!
    
    @IBOutlet weak var settingScoreLbl: UILabel!
    
    
    var post: Post? {
        
        didSet{
            setupCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    fileprivate func setupCell(){
        
        if let p = post {
            self.restoNameLbl.text = p.name
            self.restoTypeLbl.text = p.type
            self.restoImageView.image = p.image
        }
    }

}
