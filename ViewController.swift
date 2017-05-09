//
//  ViewController.swift
//  WeatherToday
//
//  Created by reena on 04/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var dayDescription: UILabel!
    
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var mornTemp: UILabel!
    @IBOutlet weak var eveTemp: UILabel!
    
    @IBOutlet weak var dayTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var nightTemp: UILabel!
    
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windDegree: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    var city_name: [NSManagedObject] = []
    
    var pageIndex: Int!
    var forecast: Forecast? = nil
    var hideFavButton = false
    var locationData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if hideFavButton == true{
            self.favoriteButton.isHidden = true
        }
        if ((pageIndex == 1) || (pageIndex == 2)) {
            self.favoriteButton.isHidden = true
        }
        
        if let forecast = forecast{
            
            self.cityName.text = forecast.cityName
            
            self.dayDescription.text = forecast.dataType[0].weather_description
            
            let dateInSeconds = forecast.dataType[0].date
            print("This SEC\(dateInSeconds)")
            self.date.text = getDateStringFromUnixTime(dateInSeconds: dateInSeconds)
            self.dayTemp.text = "\(String(format:"%.1f", forecast.dataType[0].dayTemp))"
            self.mornTemp.text = "\(String(format:"%.1f", forecast.dataType[0].mornTemp))"
            self.eveTemp.text = "\(String(format:"%.1f", forecast.dataType[0].eveTemp))"
            self.nightTemp.text = "\(String(format:"%.1f", forecast.dataType[0].nightTemp))"
            self.minTemp.text = "\(String(format:"%.1f", forecast.dataType[0].minTemp))"
            self.maxTemp.text = "\(String(format:"%.1f", forecast.dataType[0].maxTemp))"
            self.clouds.text = "\(String(format:"%.1f", forecast.dataType[0].clouds)+"%")"
            self.pressure.text = "\(String(format:"%.1f", forecast.dataType[0].pressure)+"hPa")"
            self.humidity.text = "\(String(format:"%.1f", forecast.dataType[0].humidity)+"%")"
            self.windSpeed.text = "\(String(format:"%.1f", forecast.dataType[0].wind_speed)+"mph")"
            self.windDegree.text = "\(String(format:"%.1f", forecast.dataType[0].wind_degree))"
            
            let iconname = forecast.dataType[0].icon
            let s = "http://openweathermap.org/img/w/\(iconname).png"
            let imageUrl:URL = URL(string: s)!
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.imageIcon.image = image
                self.imageIcon.contentMode = UIViewContentMode.scaleAspectFit
                self.view.addSubview(self.imageIcon)
            }
            
        }
    }
    
    func setForecast(forecast:Forecast, pageIndex:Int){
        self.forecast = forecast
        self.pageIndex = pageIndex
        
    }
    
    // Cancel or add to favourites
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removeFavouriteButtonTapped(_ sender: AnyObject) {
    }
    
    @IBAction func addToFavoriteButtonTapped(_ sender: AnyObject) {
        let cityToSave = self.cityName.text!
        
        DataSave.storeData(dataToSave: "\(cityToSave)")
        let alert = Alert.presentAlert(title: "Success", message: "City \(cityToSave) Added to your favourite")
        self.present(alert, animated: true, completion: nil)
        
        favoriteButton.setImage(UIImage(named: "redHeart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.favoriteButton.isEnabled = false
        
        print("somehwere")
        
    }
    
    //Seconds to Date String
    func getDateStringFromUnixTime(dateInSeconds: Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(dateInSeconds))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY "
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return "\(dateString)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

