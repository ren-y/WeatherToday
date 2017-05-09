//
//  FavouriteTableVC.swift
//  WeatherToday
//
//  Created by reena on 09/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import UIKit
import CoreData
class FavouriteTableVC: UITableViewController {
    
    var fav = [String]()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fav = getFavourite()
        print("\(fav.count)")
        if fav.count > 0{
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fav.count
    }
    
    func getFavourite() -> [String] {
        let fetchData = DataSave.fetchResult()
        for data in fetchData {
            if fav.contains(data) == false{
                
                self.fav.append(data)
            }
            
        }
        return fav
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = fav[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let data = (fav[indexPath.row])
        if editingStyle == .delete {
            DataSave.deleteData(dataToDelete: data)
            fav.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFav = fav[indexPath.row]
        if Reachability.isConnectedToNetwork() == true{
            let weatherForecastReport = WeatherGetter()
            
            weatherForecastReport.getWeatherReport(city: selectedFav ,completion: { (forecastDay) -> Void in
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
                    myVC.forecast = forecastDay
                    myVC.passSignalToHideButtonInContentVC = true
                    self.present(myVC, animated: true, completion: nil)
                } })
        }
        else{
            let alert = Alert.presentAlert(title: "Nothing to show", message: "Could not fetch data")
            self.present(alert, animated: true, completion: nil)
        }
    }
}
