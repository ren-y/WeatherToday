//
//  SearchTableTableViewController.swift
//  WeatherToday
//
//  Created by reena on 08/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import UIKit

class SearchTableTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    var city_List = [String]()
    var filteredName: [String] = []
    var searchActive: Bool = false
    var forecast = [Forecast]()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("city count in search load:: \(city_List.count)")
        searchBar.delegate = self
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            if(filteredName.count != 0) {
                return filteredName.count
            }
            else{
                return city_List.count
            }
        }
        else{
            return self.city_List.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if((searchActive) && (filteredName.count != 0)){
            
            cell.textLabel?.text = filteredName[indexPath.row]
        }
        else{
            cell.textLabel?.text = city_List[indexPath.row]
        }
        return cell
    }
    //Mark: Call get weather
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedCity : String!
        if(searchActive){
            if (filteredName.count != 0){
                selectedCity = filteredName[indexPath.row]
            }
            else{
                
                selectedCity = city_List[indexPath.row]
                
            }
        }
        else{
            selectedCity = city_List[indexPath.row]
        }
        print("\(selectedCity)")
        var xyz = [Forecast]()
        if Reachability.isConnectedToNetwork() == true{
            self.activityIndicator.startAnimating()
            let weatherForecastReport = WeatherGetter()
            weatherForecastReport.getWeatherReport(city: selectedCity ,completion: { (forecastDay) -> Void in
                xyz = forecastDay
                print("in before appear \(xyz.count)")
                
                DispatchQueue.main.async {
                    self.searchActive = false
                    self.activityIndicator.stopAnimating()
                    if forecastDay.count != 0 {
                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
                        myVC.forecast = forecastDay
                        self.present(myVC, animated: true, completion: nil)
                        
                    }
                    else{
                        let alert = Alert.presentAlert(title: "Network Error!!!", message: "Please check your network settings")
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            })
            
        }
        else{
            let alert = Alert.presentAlert(title: "Network Error!!!", message: "Please check your network settings")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func set(forecast:[Forecast]) {
        self.forecast = forecast
        self.performSegue(withIdentifier: "Page", sender: self)
    }
    
    //MARK: Search bar methods
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = true;
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredName = city_List.filter({ (text) -> Bool in
            let temp: String = text
            let range = temp.range(of: searchText, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)
            return (range != nil)
            
        })
        if(filteredName.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
        
    }
}

