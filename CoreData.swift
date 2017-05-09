//
//  CoreData.swift
//  WeatherToday
//
//  Created by reena on 09/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import Foundation
import UIKit
import CoreData


public class DataSave {
    class func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func storeData(dataToSave: String) {
        let context = getContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let entity =  NSEntityDescription.entity(forEntityName: "City", in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        transc.setValue(dataToSave, forKey: "city_name")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    
    class func fetchResult()-> [String]{
        
        var cityResult  = [String]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        
        do {
            let cities = try getContext().fetch(fetchRequest)
            for cityName in cities
            {
                let list = (cityName as AnyObject).value(forKey: "city_name")
                print((cityName as AnyObject).value(forKey: "city_name") ?? "no name")
                cityResult.append(list as! String)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return cityResult
    }
    
    class func deleteData(dataToDelete:String) {
        let context = getContext()
        
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        if let fetchResults = try!context.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as? [City] {
            for result in fetchResults{
                if result.city_name == [dataToDelete] {
                    context.delete(result)
                    try!context.save()
                }
            }
        }
    }
    
}

