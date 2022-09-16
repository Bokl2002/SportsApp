//
//  TeamsTableViewCell.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 10/08/2022.
//

import UIKit
import Kingfisher

class TeamsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamBedgeImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamDetailsButton: UIButton!
    
    @IBOutlet weak var stadImageImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

