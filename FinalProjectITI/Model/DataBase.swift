//
//  DataBase.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 11/08/2022.
//

import Foundation
import UIKit

var sportsDataBase: [SportDataBaseModel] = []
var leaguesDataBase:[LeagueDataBaseModel] = []
var teamsDataBase: [TeamDataBaseModel] = []

var favouriteLeagues:[LeagueDataBaseModel] = []
var isFavourite: [String: Bool] = [:]

// sports
struct SportDataBaseModel: Decodable{
    var idSport: String?
    var strSport: String?
    var strFormat: String?
    var strSportThumb: String
    var strSportIconGreen: String?
    var strSportDescription: String?
}
struct SportsDataBaseModel: Decodable{
    var sports: [SportDataBaseModel]
}


//leagues
struct LeagueDataBaseModel: Decodable{
    var strLeague: String?
    var strBadge: String?
    var strYoutube: String?
    var strSport: String?
    var strDescriptionEN: String?
    var idLeague: String?
}
struct LeaguesDataBaseModel: Decodable{
    var countries: [LeagueDataBaseModel]
}


//teams
struct TeamDataBaseModel: Decodable{
    var strSport: String?       // search
    var strLeague: String?      // search
    var strTeam: String?
    var strTeamBadge: String?
    var strDescriptionEN: String? // league
    var strStadiumThumb: String?
    var strStadiumDescription: String?
    var strYoutube: String?
    
}
struct TeamsDataBaseModel: Decodable{
    var teams:[TeamDataBaseModel]
}

