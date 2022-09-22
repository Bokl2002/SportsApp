//
//  FavouritViewController.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 09/08/2022.
//

import UIKit

class FavouritViewController: UIViewController {

    @IBOutlet weak var favouritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouritesTableView.reloadData()
    }
    
    @objc func openVideo(_ sender: UIButton){
        if let urlStr = favouriteLeagues[sender.tag].strYoutube{
            let url = "https://" + urlStr
            UIApplication.shared.open(URL(string: url)!)
        }
    }
}

extension FavouritViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell") as! FavouriteCellTableViewCell
        
        let idx = indexPath.row
        cell.leagueTitleLabel.text = favouriteLeagues[idx].strLeague
        
        cell.leagueImage.kf.setImage(with: URL(string: favouriteLeagues[idx].strBadge ?? "defaultImage"))
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.width/2
        
        if let x = favouriteLeagues[idx].strYoutube{
            cell.leagueVideoBTN.tag = indexPath.row
            cell.leagueVideoBTN.isEnabled = true
            if x.isEmpty{
                cell.leagueVideoBTN.tintColor = .systemGray5
                cell.leagueVideoBTN.isEnabled = false
            }
        }else{
            cell.leagueVideoBTN.tintColor = .systemGray5
            cell.leagueVideoBTN.isEnabled = false
        }
        cell.leagueVideoBTN.addTarget(self, action: #selector(openVideo), for: .touchUpInside)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let leagueDetailsVC = storyboard?.instantiateViewController(withIdentifier: "leagueDetailsVC") as! LeagueDetailsViewController
        leagueDetailsVC.leagueDataBase = favouriteLeagues[indexPath.row]
        
        leagueDetailsVC.modalPresentationStyle = .fullScreen
        present(leagueDetailsVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
