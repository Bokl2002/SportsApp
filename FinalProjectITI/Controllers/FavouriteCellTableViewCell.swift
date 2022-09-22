//
//  FavouriteCellTableViewCell.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 22/09/2022.
//

import UIKit

class FavouriteCellTableViewCell: UITableViewCell {
    // variables
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueTitleLabel: UILabel!
    @IBOutlet weak var leagueVideoBTN: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
