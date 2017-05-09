//
//  WeatherGetter.swift
//  WeatherToday
//
//  Created by reena on 04/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import Foundation
import UIKit

class WeatherGetter {

    var day1WeatherInDetail = [String: AnyObject]()
    var day2WeatherInDetail = [String:AnyObject]()
    var day3WeatherInDetail = [String:AnyObject]()
    
    var dayW = [[String:AnyObject]]()
    var dayD = [[String:AnyObject]]()
    var temps = [[String:AnyObject]]()
    var forecast = [Forecast]()
    
    enum MyError: Error {
        case FoundNil(String)
        case SerializationError(String)
        case DataPopulateError(String)
    }
    
    func getWeatherReport(city: String,completion: @escaping ([Forecast]) -> ()){
        let session = URLSession.shared
        let requestURL = URL(string: "\(weatherURL)&q=\(city)")
        if let url = requestURL {
            let dataTask = session.dataTask(with: url){data,response,error in
                if error != nil{
                    print(error)
                    
                }
                else{
                    do{
                        guard let jsonData = data else{
                            
                            throw MyError.FoundNil("JSON data issue!!!")
                        }
                        guard let dictionaryData = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String:AnyObject] else{
                            throw MyError.SerializationError("Unable to serialize")
                        }
                        print("HERE IT IS:::\(dictionaryData.description)")
                        //day 1 2 3
                        guard let cityName = dictionaryData["city"]!["name"]!,
                            let day1 = dictionaryData["list"]![0]! as? [String: AnyObject],
                            let day2 = dictionaryData["list"]![1]! as? [String: AnyObject],
                            let day3 = dictionaryData["list"]![2]! as? [String: AnyObject],
                            let temp1 = day1["temp"] as? [String: AnyObject],
                            let temp2 = day2["temp"] as? [String: AnyObject],
                            let temp3 = day3["temp"] as? [String: AnyObject],
                            let weatherDay1 = day1["weather"]![0]! as? [String:AnyObject],
                            let weatherDay2 = day2["weather"]![0]! as? [String:AnyObject],
                            let weatherDay3 = day3["weather"]![0]! as? [String:AnyObject]
                            else {
                                throw MyError.DataPopulateError("Mismatch in assigning values from dictionary")
                        }
                        self.dayW.append(day1)
                        self.dayW.append(day2)
                        self.dayW.append(day3)
                        
                        self.dayD.append(weatherDay1)
                        self.dayD.append(weatherDay2)
                        self.dayD.append(weatherDay3)
                        
                        self.temps.append(temp1)
                        self.temps.append(temp2)
                        self.temps.append(temp3)
                        print(self.dayW.count)
                        print(self.dayD.count)
                        
                        let today = Forecast(cityName: cityName as! String, dataType: [Weather(dayDic: self.dayW[0], weatherDic: self.dayD[0],temp:self.temps[0])])
                        let tomorrow = Forecast(cityName: cityName as! String, dataType: [Weather(dayDic: self.dayW[1], weatherDic: self.dayD[1],temp:self.temps[1])])
                        let overmorrow = Forecast(cityName: cityName as! String, dataType: [Weather(dayDic: self.dayW[2], weatherDic: self.dayD[2],temp:self.temps[2])])
                        
                        self.forecast.append(contentsOf: [today, tomorrow, overmorrow])
                        print(today.cityName)
                        print(today.dataType[0].weather_description)
                        print(today.dataType[0].dayTemp)
                        print(today.dataType[0].wind_degree)
                        
                        print("in FORECAST IN GETTER appear \(self.forecast.count)")
                        
                        completion(self.forecast)
                        
                    }
                    catch{
                        print(error)
                    }
                    
                    
                }
            }
            
            dataTask.resume()
        }
    }
    
    
    func jsonToDict(_ text: String) -> [String:AnyObject]? {
        
        //string into an NSData object using UTF8 encoding
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                //NSData into Dictionary
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
            } catch _ as NSError {
                // Do something more useful!
            }
        }
        return nil
    }
    
    func setLabels(_: Forecast){
        
    }
}
