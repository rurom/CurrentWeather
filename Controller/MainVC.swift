//
//  ViewController.swift
//  CurrentWeather
//
//  Created by Roman on 2/7/18.
//  Copyright © 2018 Roman Rudavskiy. All rights reserved.
//

import UIKit

struct City {
   let id:String
   let name:String
}

//API key for OpenWeatherMap
let apikey = "d2bd923726d8850b7677856f80cb52cd"

class MainVC: UITableViewController {
    
    let hardcodedCities = [City(id:"702550", name:"Lviv"), City(id:"2988507", name:"Paris"), City(id:"3128760", name:"Barcelona"), City(id:"292223", name:"Dubai"), City(id:"184745", name:"Nairobi"), City(id:"993800", name:"Johannesburg"), City(id:"1642911", name:"Jakarta"), City(id:"1850144", name:"Tokyo"), City(id:"796236", name:"Shanghai"), City(id:"1273294", name:"Delhi"), City(id:"2147714", name:"Sydney"), City(id:"3936456", name:"Lima"), City(id:"3435910", name:"Buenos Aires"), City(id:"856195", name:"Honolulu"), City(id:"5368361", name:"Los Angeles"), City(id:"5128581", name:"New York"), City(id:"6167865", name:"Toronto"), City(id:"5879400", name:"Anchorage"), ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hardcodedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"Cell") else { return UITableViewCell()}
        
        let city = hardcodedCities[indexPath.row]
        
        cell.textLabel?.text = city.name
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}//class

