//
//  ViewController.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 08/08/2022.
//

import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController {
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        navigationController?.navigationBar.barStyle = .black
        loadData()
    }
    
    func loadData(){
        // sports
        AF.request("https://www.thesportsdb.com/api/v1/json/2/all_sports.php").responseDecodable(of: SportsDataBaseModel.self) { response in
            guard let temp = response.value else{return}
            sportsDataBase = temp.sports
            self.sportsCollectionView.reloadData()
        }
        
//        // leagues
        AF.request("https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England").responseDecodable(of: LeaguesDataBaseModel.self) { response in
            guard let temp = response.value else{return}
            leaguesDataBase = temp.countries


        }

        //teams
        AF.request("https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League").responseDecodable(of: TeamsDataBaseModel.self) { response in
            guard let temp = response.value else {return}
            teamsDataBase = temp.teams

        }
        
        // Favourite Leagues
        CoreData.fetchingFromCoreData()

    }
}


extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsDataBase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportcell", for: indexPath) as! SportCollectionViewCell
        let idx = indexPath.row
        cell.sportTextField.text = sportsDataBase[idx].strSport
        cell.sportImageView.kf.setImage(with: URL(string: sportsDataBase[idx].strSportThumb)){
            result in
            switch result {
                case .failure:
                    cell.sportImageView.image = UIImage(named: "notFound")
                    cell.sportImageView.contentMode = .scaleAspectFit
                case .success:
                    cell.sportImageView.contentMode = .scaleAspectFill
            }

        }
                
        // reduce image opacity to show the text above
        cell.sportImageView.layer.opacity = 0.8
        // circular img
        cell.sportImageView.layer.cornerRadius = cell.sportImageView.layer.frame.width / 2
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width * 0.499, height: 150)
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let LeaguesViewController = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as? LeaguesViewController
        guard let LVC = LeaguesViewController else{return}
        LVC.sportName = sportsDataBase[indexPath.row].strSport ?? "nosports"
        navigationController?.pushViewController(LVC, animated: true)
    }
    
}

