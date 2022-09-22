//
//  TeamDetailsViewController.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 10/08/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var teamData: TeamDataBaseModel!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamDetailsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        teamNameLabel.text = teamData.strTeam ?? ""
        teamDetailsTextView.isEditable = false
        teamDetailsTextView.text = teamData.strDescriptionEN ?? ""
        
    }
    
    @IBAction func teamYoutubeBTN(_ sender: Any) {

        let url = "https://" + (teamData.strYoutube ?? "")
        UIApplication.shared.open(URL(string: url)!)
    }
    
    @IBAction func teamDetailBackBTN(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
