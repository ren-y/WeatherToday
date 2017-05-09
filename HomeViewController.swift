//
//  HomeViewController.swift
//  WeatherToday
//
//  Created by reena on 08/05/17.
//  Copyright © 2017 Reena. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var names: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readJson()
    }
    
    @IBAction func searchTapped(_ sender: AnyObject) {
        print(names.count)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextScene = segue.destination as? SearchTableTableViewController
        nextScene?.city_List = names
    }
    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "cityList", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [[String:Any]] {
                    DispatchQueue.global(qos: .background).async {
                        for obj in object {
                            let city = obj["name"]
                            self.names.append(city as! String)
                        }
                    }
                }
                else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}

