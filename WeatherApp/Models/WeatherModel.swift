//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Marina on 02/07/2021.
//

import Foundation
class WeatherModel {
    var mainTemprature:Double
    var cityName:String
    var description:String
    var descriptionIconId:Int
    var descriptionIconName:String{
            var conditionIconName = ""
            switch descriptionIconId {
            case 200...232:
                conditionIconName = "cloud.bolt"
                break
            case 300...321:
                conditionIconName = "cloud.drizzle"
                break
            case 500...531:
                conditionIconName = "cloud.rain"
                break
            case 600...622:
                conditionIconName = "cloud.snow"
                break
            case 701...781:
                conditionIconName = "cloud.fog"
                break
            case 800:
                conditionIconName = "sun.max"
                break
            case 801:
                conditionIconName = "cloud.sun"
                break
            case 802...804:
                conditionIconName = "cloud"
                break
            default:
                conditionIconName = "sun.max"
            }
            return conditionIconName
    }
    var humidity:Int
    
    init(mainTemprature mt:Double , cityName cn:String , description d:String, descriptionIconId dii:Int, humidity h:Int) {
        mainTemprature = mt
        cityName = cn
        description = d
        descriptionIconId = dii
        humidity = h
    }
}
