//
//  Helper.swift
//  CurrentWeather
//
//  Created by Roman on 2/12/18.
//  Copyright © 2018 Roman Rudavskiy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //function for getting cities id's
    func getIDsArr() {
        
        for var i in 0..<hardcodedCities.count {
            iDsArr.append(hardcodedCities[i].id)
            i+=1
        }
    }//func
    
    
    //parsing json data for all cities at once, and storing them into weatherList array for further usage
    func parseWeatherJson() {
        
        //transform array of strings into string
        let iDsList = iDsArr.joined(separator: ",")
        
        //generating url
        let currentWeatherJsonUrl = ("https://api.openweathermap.org/data/2.5/group?id=\(iDsList)&units=metric&APPID=\(apikey)")
        
        
        print("currentWeatherJsonUrl:\(currentWeatherJsonUrl)")
        
        
        guard let currentWeatherUrl = URL(string: currentWeatherJsonUrl) else { return }
        
        
        //Parsing current weather JSON
        URLSession.shared.dataTask(with: currentWeatherUrl) { (data, response, err) in
            
            //check err
            if err != nil {
                print("Error:\(String(describing: err))")
            }
            
            
            guard let data = data else { return }
            
            do {
                
                let currentWeatherData = try JSONDecoder().decode(WeatherDataJson.self, from: data)
                
                
                weatherList = currentWeatherData.list
                
                
                print(weatherList[3].weather)
                print(weatherList)
                
                
            } catch let jsonErr {
                print("Error:\(jsonErr)")
            }
            
            }.resume()//URLSession
        
    }//func
    
    //Checking internet rechability
    @objc func internetReachability () {
        
        let reachability =  InternetReachability()!
        //reachability.isReachable is deprecated, right solution --> connection != .none
        if reachability.connection != .none {
            //reachability.isReachableViaWiFi is deprecated, right solution --> connection == .wifi
            if reachability.connection == .wifi {
                DispatchQueue.main.async {
                    print("Internet via WIFI is OK!")
                    //parse json
                    self.parseWeatherJson()
                }
                
            } else {
                DispatchQueue.main.async {
                    print("Internet via Cellular is OK!")
                    //parse json
                    self.parseWeatherJson()
                }
            }
        } else {
            print("Please check your Internet connection!")
            inetAlert()
        }
    }
    
    //Alert when internet is offline
    func inetAlert() {
        //Alert Pop-up no internet connection
        let alertController = UIAlertController(title: "", message: "Please, check your internet connection", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //Autoupdate data every 2 min, if user stays at SwipingController
    func autoUpdate() {
        Timer.scheduledTimer(timeInterval: TimeInterval(120), target: self, selector: #selector(internetReachability), userInfo: nil, repeats: true)
    }

}//extension
