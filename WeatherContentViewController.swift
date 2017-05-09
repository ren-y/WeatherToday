//
//  WeatherContentViewController.swift
//  WeatherToday
//
//  Created by reena on 05/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import UIKit

class WeatherContentViewController: UIViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var mainWeatherDesc: UILabel!
    @IBOutlet weak var tempAvg: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windDegree: UILabel!
    @IBOutlet weak var pressure: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
