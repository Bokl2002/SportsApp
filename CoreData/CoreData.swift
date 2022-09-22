//
//  CoreData.swift
//  FinalProjectITI
//
//  Created by Abdullah Elbokl on 22/09/2022.
//

import Foundation
import CoreData

struct CoreData{
    
    // insert
    static func newFavouritCoreData(_ detailsData: LeagueDataBaseModel){
        let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: Context)
        let newFavourit = NSManagedObject(entity: entity!, insertInto: Context)
        newFavourit.setValue(detailsData.idLeague, forKey: "idLeague")
        newFavourit.setValue(detailsData.strLeague, forKey: "strLeague")
        newFavourit.setValue(detailsData.strBadge, forKey: "strBadge")
        newFavourit.setValue(detailsData.strYoutube, forKey: "strYoutube")
        newFavourit.setValue(detailsData.strSport, forKey: "strSport")
        newFavourit.setValue(detailsData.strDescriptionEN, forKey: "strDescriptionEN")
        do {
            try Context.save()
        } catch{
            print(error)
        }
    }
    // fetch
    static func fetchingFromCoreData(){
        let request = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        request.returnsObjectsAsFaults = false
        do {
            let result = try Context.fetch(request)
            for data in result {
                let league = LeagueDataBaseModel(
                    strLeague: (data.value(forKey: "strLeague") as! String),
                    strBadge: (data.value(forKey: "strBadge") as! String),
                    strYoutube: (data.value(forKey: "strYoutube") as! String),
                    strSport: (data.value(forKey: "strSport") as! String),
                    strDescriptionEN: (data.value(forKey: "strDescriptionEN") as! String),
                    idLeague: (data.value(forKey: "idLeague") as! String)
                )
                favouriteLeagues.append(league)
                guard let id = data.value(forKey: "idLeague") as? String else {return}
                isFavourite[id] = true
            }
        } catch {
            print(error)
        }
    }
    // delete
    static func deleteFromCoreData(_ data: LeagueDataBaseModel){
        let request = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        request.predicate = NSPredicate(format: "idLeague = %@", "\(data.idLeague!)")
        do {
            let result = try Context.fetch(request)
            guard let dataWillBeRemoved = result.first else {return}
            Context.delete(dataWillBeRemoved)
            try Context.save()
        } catch {
            print(error)
        }

    }
    
    // delete all
    static func deleteAllFromCoreData(){
        let request = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        do {
            let result = try Context.fetch(request)
            for data in result{
                Context.delete(data)
            }
            try Context.save()
        } catch {
            print(error)
        }

    }
}
