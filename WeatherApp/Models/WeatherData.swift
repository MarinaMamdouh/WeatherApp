//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Marina on 02/07/2021.
//

import Foundation

struct WeatherData: Decodable {
    var name:String // city name
    var weather:[WeatherDescriptionData]
    var main: DetailedTempratureData
}
struct WeatherDescriptionData:Decodable {
    var main:String // weather description title
    var description:String // weather description
    var id:Int // id of icon of weather description
}

struct DetailedTempratureData:Decodable {
    var temp:Double // main temprature
    var humidity:Int // humidity rate
}
