//
//  WeatherDataModel.swift
//  CurrentWeather
//
//  Created by Roman on 2/8/18.
//  Copyright © 2018 Roman Rudavskiy. All rights reserved.
//

import Foundation

class WeatherDataJson:Decodable {
    let cnt:Int
    let list:[List]
    
    init(cnt:Int, list:[List]) {
        self.cnt = cnt
        self.list = list
    }
}

class List:Decodable {
    
    let coord:Coord?
    let sys:Sys?
    let weather:[Weather?]
    let main:Main
    let visibility:Int?
    let wind:Wind?
    let clouds:Clouds?
    let dt:Int?
    let id:Int?
    let name:String?
    
    init(coord:Coord, sys:Sys, weather:[Weather], main:Main, visibility:Int, wind:Wind, clouds:Clouds, dt:Int, id:Int, name:String) {
        
        self.coord = coord
        self.sys = sys
        self.weather = weather
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.id = id
        self.name = name
 }
    
}

class Coord:Decodable {
    let lon:Double?
    let lat:Double?
    
    init(lon:Double, lat:Double) {
        self.lon = lon
        self.lat = lat
    }
}

class Sys:Decodable {
    let type:Int?
    let id:Int?
    let message:Double?
    let country:String?
    let sunrise:Int?
    let sunset:Int?
        
    init(type:Int, id:Int, message:Double, country:String, sunrise:Int, sunset:Int) {
        self.type = type
        self.id = id
        self.message = message
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

class Weather:Decodable {
    let id:Int?
    let main:String?
    let description:String?
    let icon:String?
    
    init(id:Int, main:String, description:String, icon:String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

class Main:Decodable {
    let temp:Double
    let pressure:Double?
    let humidity:Int?
    let temp_min:Double?
    let temp_max:Double?
    
    init(temp:Double, pressure:Double, humidity:Int, temp_min:Double, temp_max:Double) {
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.temp_min = temp_min
        self.temp_max = temp_max
    }
}

class Wind:Decodable {
    let speed:Double?
    let deg:Double?
    
    init(speed:Double, deg:Double) {
        self.speed = speed
        self.deg = deg
    }
}

class Clouds:Decodable {
    let all:Int?
    
    init(all:Int) {
        self.all = all
    }
}


