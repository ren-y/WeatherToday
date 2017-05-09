//
//  weatherModel.swift
//  WeatherToday
//
//  Created by reena on 04/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import Foundation
import UIKit


struct Forecast {
    let cityName: String
    let dataType: [Weather]
    
}
struct Weather{
    
    let date: Double
    var weather_description: String
    let clouds: Double
    let dayTemp: Double
    let mornTemp:Double
    let eveTemp:Double
    let nightTemp:Double
    let minTemp: Double
    let maxTemp: Double
    let wind_speed: Double
    let wind_degree:Double
    let pressure: Double
    let humidity: Double
    
    let icon:String
    
    init(dayDic: [String:AnyObject],weatherDic:[String:AnyObject],temp:[String:AnyObject]) {
        self.date = dayDic["dt"] as! Double
        self.weather_description = weatherDic["description"]! as! String
        self.clouds = dayDic["clouds"] as! Double
        self.dayTemp = temp["day"] as! Double
        self.mornTemp = temp["morn"] as! Double
        self.eveTemp = temp["eve"] as! Double
        self.nightTemp = temp["night"] as! Double
        self.minTemp = temp["min"] as! Double
        self.maxTemp = temp["max"] as! Double
        self.icon = weatherDic["icon"] as! String
        self.wind_speed = dayDic["speed"] as! Double
        self.wind_degree = dayDic["deg"] as! Double
        self.humidity = dayDic["humidity"] as! Double
        self.pressure = dayDic["pressure"] as! Double
        
    }
    
    
}
