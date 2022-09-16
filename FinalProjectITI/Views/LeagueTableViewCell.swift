//
//  LeagueTableViewCell.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 09/08/2022.
//

import UIKit
import Kingfisher

class LeagueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueImageViewCell: UIImageView!
    @IBOutlet weak var leagueVideoTableViewCell: UIButton!
    @IBOutlet weak var leagueTitleTableViewCell: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
}
