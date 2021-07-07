//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Marina on 02/07/2021.
//

import Foundation
protocol WeatherManagerDelegate {
    func didUpdateWeather(weather:WeatherModel)
    func didFailWithError(error:Error)
}
class WeatherManager{
    static var mainTempratureUnit = TempratureUnits.Celsius
    static var secondTempratureUnit = TempratureUnits.Fahrenheit
    
    var delegate:WeatherManagerDelegate?
    
    func getWeather(forLocation latitude:Double , longitude:Double , unit:TempratureUnits){
        let urlString = "\(K.WEATHER_API_URL)?\(K.API_KEY)" +
            "&\(unit.rawValue)&\(K.API_LATITUDE_FIELD_NAME)\(latitude)&\(K.API_LONGITUDE_FIELD_NAME)\(longitude)"
        performRequest(urlString: urlString)
        
    }
    
    func getWeather(for city:String, unit:TempratureUnits) {
        let urlString = "\(K.WEATHER_API_URL)?\(K.API_KEY)" +
            "&\(unit.rawValue)&\(K.API_CITY_FIELD_NAME)\(city)"
        performRequest(urlString: urlString)
    }
    
    private func performRequest(urlString:String) {
        // 1- Create URL
        if let url =  URL(string: urlString){
            // 2- Create Session
            let session = URLSession(configuration: .default)
            // 3- Create Task for the session
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    self.delegate?.didFailWithError(error: e)
                    return
                }
                if let mydata = data {
                    self.parseDataToJSON(data: mydata)
                }
            }
            
            // 4- Start the Task
            task.resume()
        }
        
    }
    
    private func parseDataToJSON(data:Data){
        let decoder = JSONDecoder()
        do{
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            let weather = WeatherModel(mainTemprature: weatherData.main.temp, cityName: weatherData.name, description: weatherData.weather[0].description, descriptionIconId: weatherData.weather[0].id, humidity: weatherData.main.humidity)
            self.delegate?.didUpdateWeather(weather: weather)
            
        }
        catch{
            print(error)
            self.delegate?.didFailWithError(error: error)
        }
    }

    
}

enum TempratureUnits:String {
    case Celsius = "units=metric"
    case Fahrenheit = "units=standard"
}

