//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Marina on 07/07/2021.
//

import Foundation
extension  Date {
    func formatDate(format:String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)

    }
}
