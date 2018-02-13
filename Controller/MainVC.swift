//
//  ViewController.swift
//  CurrentWeather
//
//  Created by Roman on 2/7/18.
//  Copyright © 2018 Roman Rudavskiy. All rights reserved.
//

import UIKit

//Struct for hardcoded array
struct City {
   let id:String
   let name:String
}

//API key for OpenWeatherMap
let apikey = "d2bd923726d8850b7677856f80cb52cd"

//Array for weather Data for all hardcoded cities
var weatherList = [List]()

//Array for getting cities id's
var iDsArr = [String]()

//Variable for handling right order of cities in SwipingController, by default = 0
var currentRow:Int  = 0

//Hardcoded array of the cities
 let hardcodedCities = [City(id:"3413829", name:"Reykjavik"), City(id:"3143244", name:"Oslo"), City(id:"702550", name:"Lviv"), City(id:"3128760", name:"Barcelona"), City(id:"292223", name:"Dubai"), City(id:"184745", name:"Nairobi"), City(id:"993800", name:"Johannesburg"), City(id:"1642911", name:"Jakarta"), City(id:"1850144", name:"Tokyo"), City(id:"1796236", name:"Shanghai"), City(id:"1273294", name:"Delhi"), City(id:"2147714", name:"Sydney"), City(id:"3936456", name:"Lima"), City(id:"3435910", name:"Buenos Aires"), City(id:"5368361", name:"Los Angeles"), City(id:"5128581", name:"New York"), City(id:"6167865", name:"Toronto"), City(id:"5879400", name:"Anchorage"), ]



class MainVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //function for getting cities id's
        getIDsArr()
        
        //parsing json data for all cities at once, and storing them into weatherList array for further usage
        parseWeatherJson()
        
    }
        

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hardcodedCities.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let source = hardcodedCities[indexPath.row]
        
        currentRow = indexPath.row
        
        performSegue(withIdentifier: "SwipingController", sender: source)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SwipingController" {
            _ = segue.destination as? SwipingController
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"Cell") else { return UITableViewCell()}
        
        let city = hardcodedCities[indexPath.row]
        
        cell.textLabel?.text = city.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}//class



