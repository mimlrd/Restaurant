//
//  RestaurantCardCell.swift
//  Restaurant
//
//  Created by Mike Milord on 04/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import UIKit

class RestaurantCardCell: UITableViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cartTitleLbl: UILabel!
    @IBOutlet weak var cardRestaurantTypeLbl: UILabel!
    @IBOutlet weak var cardShortSummaryLbl: UILabel!
    @IBOutlet weak var cardRestaurantAddressLbl: UILabel!
    
    

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
}
