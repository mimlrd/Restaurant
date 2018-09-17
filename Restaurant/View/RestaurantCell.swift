//
//  RestaurantCell.swift
//  Restaurant
//
//  Created by Mike Milord on 04/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    @IBOutlet weak var restuarantImageView: UIImageView!
    
    @IBOutlet weak var restaurantNameLbl: UILabel!
    
    @IBOutlet weak var restaurantTypeLbl: UILabel!
    
    @IBOutlet weak var restaaurantDetailLbl: UILabel!
    
    @IBOutlet weak var restaurantAddrLbl: UILabel!
    
    
    // Review scores
    @IBOutlet weak var restoCuisineScoreLbl: UILabel!
    
    @IBOutlet weak var restoSettingScoreLbl: UILabel!
    
    @IBOutlet weak var restoServiceScoreLbl: UILabel!
    
    // background view
    
    @IBOutlet weak var bgShadowView: UIView!
    
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
            self.restuarantImageView.image = p.image
            self.restaurantNameLbl.text = p.name
            self.restaurantTypeLbl.text = p.type
            self.restaaurantDetailLbl.text = p.bio
            self.restaurantAddrLbl.text = p.address
        }
    }

}
