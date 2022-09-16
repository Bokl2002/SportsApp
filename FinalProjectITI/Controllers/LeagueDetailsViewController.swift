//
//  LeagueDetailsViewController.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 09/08/2022.
//

import UIKit
import Kingfisher
import Alamofire


var teamsIsEmpty: Bool!


func classifyTeams (myData: [TeamDataBaseModel], leagueName: String)->[TeamDataBaseModel]{
    var temp:[TeamDataBaseModel] = []
    for i in myData{
        if i.strLeague! == leagueName{
            temp.append(i)
        }
    }
    if temp.isEmpty{
        teamsIsEmpty = true
    }else{
        teamsIsEmpty = false
    }
    return temp
}

class LeagueDetailsViewController: UIViewController{
    var leagueName: String = ""
    var leagueDataBase: LeagueDataBaseModel!
    var teamsData: [TeamDataBaseModel] = []
    
    
    @IBOutlet weak var teamsTableView: UITableView!
    @IBOutlet weak var leagueImageViewImage: UIImageView!
    @IBOutlet weak var leagueDetailsTextView: UITextView!
    @IBOutlet weak var notFoundImage: UIImageView!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    // light status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        leagueDetailsTextView.isEditable = false
        
        //
        leagueDetailsVC()

        teamsData = classifyTeams(myData: teamsDataBase, leagueName: self.leagueName)
        if teamsData.isEmpty{
            self.teamsTableView.isHidden = true
            self.notFoundImage.isHidden = false
            self.notFoundLabel.isHidden = false
            
            self.notFoundImage.image = UIImage(named: "notFound")
            self.notFoundLabel.text = "No details found"
        }else{
            self.teamsTableView.isHidden = false
            self.notFoundImage.isHidden = true
            self.notFoundLabel.isHidden = true
            self.teamsTableView.reloadData()
        }
        
    }
    @IBAction func backFromLeagueDetailsVC(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // league Details
    func leagueDetailsVC(){
        if let temp = leagueDataBase.strLeague{
            self.leagueName = temp
        }else{
            self.leagueName = "name not found"
        }
        
        if let url = leagueDataBase?.strBadge{
            leagueImageViewImage.kf.setImage(with: URL(string: url)){
                result in
                switch result{
                    case .failure:
                        self.leagueImageViewImage.contentMode = .scaleAspectFit
                        self.leagueImageViewImage.image = UIImage(named: "notFound")
                    default: break
                }
            }
        }else{
            self.leagueImageViewImage.contentMode = .scaleAspectFit
            self.leagueImageViewImage.image = UIImage(named: "notFound")
        }
        
        if let temp = leagueDataBase?.strDescriptionEN{
            leagueDetailsTextView.text = temp
        }else{
            leagueDetailsTextView.text = "No details found"
        }
        leagueDetailsTextView.textAlignment = .center

    }
  
}

extension LeagueDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamsCell") as! TeamsTableViewCell
        let idx = indexPath.row
        cell.teamNameLabel.text = "\(teamsData[idx].strTeam!)"
        if let url = teamsData[idx].strTeamBadge{
            cell.teamBedgeImageView.kf.setImage(with: URL(string: url)){stat in
                switch stat{
                    case .failure:
                        cell.teamBedgeImageView.contentMode = .scaleAspectFit
                        cell.teamBedgeImageView.image = UIImage(named: "notfound")
                    default: break
                }
            }
        }else{
            cell.teamBedgeImageView.contentMode = .scaleAspectFit
            cell.teamBedgeImageView.image = UIImage(named: "notfound")
        }
        if let url = teamsData[idx].strStadiumThumb{
            cell.stadImageImageView.kf.setImage(with: URL(string: url)){stat in
                switch stat{
                    case .failure:
                        cell.stadImageImageView.contentMode = .scaleAspectFit
                        cell.stadImageImageView.image = UIImage(named: "notfound")
                    default: break
                }
            }
        }else{
            cell.stadImageImageView.contentMode = .scaleAspectFit
            cell.stadImageImageView.image = UIImage(named: "notfound")
        }
        
        // details button
        cell.teamDetailsButton.tag = idx
        cell.teamDetailsButton.addTarget(self, action: #selector(viewTeamDetailsButton), for: .touchUpInside)
        
        return cell
    }
    @objc func viewTeamDetailsButton(_ sender: UIButton){
        let idx = sender.tag
        let vc = storyboard?.instantiateViewController(withIdentifier: "teamDetailsVC") as? TeamDetailsViewController
        guard  let VC = vc else{return}
        VC.teamData = teamsDataBase[idx]
        present(VC, animated: true)
    }
    
}

extension LeagueDetailsViewController:  UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
