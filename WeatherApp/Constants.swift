//
//  Constants.swift
//  WeatherApp
//
//  Created by Marina on 05/07/2021.
//

import Foundation
struct K {
    static let WEATHER_API_URL = "https://api.openweathermap.org/data/2.5/weather"
    
    static let API_KEY = "appid=26db8c1654a5e69beccdcc2b786cf70d"
    static let API_UNIT_CELSIUS = "unit=metric"
    static let API_UNIT_FAHRENHEIT = "unit=standard"
    static let API_LONGITUDE_FIELD_NAME = "lon="
    static let API_LATITUDE_FIELD_NAME = "lat="
    static let API_CITY_FIELD_NAME = "q="
    static let FONT_COLOR_SET = "FontColor"
    static let STANDARD_DATE_FORMATE = "EEEE d MMMM yyyy"
    static let AMERICAN_DATE_FORMATE = "EEEE MMMM d yyyy"
    static let SEARCH_ICON_NAME = "magnifyingglass"
}
