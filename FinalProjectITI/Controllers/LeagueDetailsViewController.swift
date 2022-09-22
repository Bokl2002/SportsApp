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




class LeagueDetailsViewController: UIViewController{
    
    // global variables
    var leagueName: String = ""
    var leagueDataBase: LeagueDataBaseModel!
    var teamsData: [TeamDataBaseModel] = []
    
    // outlets
    @IBOutlet weak var teamsTableView: UITableView!
    @IBOutlet weak var leagueImageViewImage: UIImageView!
    @IBOutlet weak var leagueDetailsTextView: UITextView!
    @IBOutlet weak var notFoundImage: UIImageView!
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var favouriteBTN: UIBarButtonItem!
    
    
    // light status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        leagueDetailsTextView.isEditable = false
        
        leagueDetailsVC()
        teamsData = classifyTeams(myData: teamsDataBase, leagueName: self.leagueName)
    }
    override func viewWillAppear(_ animated: Bool) {
        checkFavourite()
        checkEmpty()
    }
    
    func checkEmpty(){
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
    func checkFavourite(){
        guard let id = leagueDataBase.idLeague else {return}
        if isFavourite[id] == true{
            favouriteBTN.image = UIImage(systemName: "star.fill")
        }else{
            favouriteBTN.image = UIImage(systemName: "star")
        }
    }
    
    // league Details
    func leagueDetailsVC(){
        name()
        image()
        description()
    }
    func name(){
        if let temp = leagueDataBase.strLeague{
            self.leagueName = temp
        }else{
            self.leagueName = "name not found"
        }
    }
    func image(){
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
    }
    func description(){
        if let temp = leagueDataBase?.strDescriptionEN{
            leagueDetailsTextView.text = temp
        }else{
            leagueDetailsTextView.text = "No details found"
        }
        leagueDetailsTextView.textAlignment = .center
    }
    
    // filteration
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
    
    // actions
    @IBAction func backFromLeagueDetailsVC(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func favouriteBTN(_ sender: Any) {
        guard let id = leagueDataBase.idLeague else {return}
        if isFavourite[id] != true{
            isFavourite[id] = true
            favouriteBTN.image = UIImage(systemName: "star.fill")
            favouriteLeagues.append(leagueDataBase)
        }else{
            isFavourite[id] = false
            favouriteBTN.image = UIImage(systemName: "star")
            for league in 0..<favouriteLeagues.count{
                if favouriteLeagues[league].idLeague == id{
                    favouriteLeagues.remove(at: league)
                    break
                }
            }
        }
        
    }
    
  
}

// MARK: Table
extension LeagueDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    // sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamsData.count
    }
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamsCell") as! TeamsTableViewCell
        // title
        cell.teamNameLabel.text = "\(teamsData[idx].strTeam!)"
        // image
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
        // stadium
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
