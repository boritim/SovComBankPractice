//
//  DateFormatter.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 11.07.2022.
//

import UIKit

class NotifyDateFormatter: DateFormatter {
    
    func convertDateString(dateString: String,
                           fromFormat sourceFormat: String!,
                           toFormat desFormat: String!) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = desFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC+8")
        return dateFormatter.string(from: date!)
    }
    func convertDateCity(dateString: String, city: [String]) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        guard let date = dateFormatter.date(from: dateString) else { return [] }
        var convertedDate: [String] = []
        //        dateFormatter.timeZone = TimeZone(identifier: "Europe/\(city)")
        for city in city {
            dateFormatter.timeZone = TimeZone(identifier: "\(city)")
            convertedDate.append(dateFormatter.string(from: date))
            //            dateFormatter.string(from: date)
        }
        return convertedDate
    }
    
    func convertDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd/MMyyyy"
        return dateFormatter.string(from: date!)
    }
    func convertDatetoDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        guard let date = dateFormatter.date(from: dateString) else { return Date() }
        return date
    }
    
    override func string(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
        return formatter.string(from: date)
    }
    
    func showTimeZones() {
        var secondsFromGMT: Int { return TimeZone.current.secondsFromGMT() }
        print(secondsFromGMT)
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        print(localTimeZoneAbbreviation)
        var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
        print(localTimeZoneIdentifier)
        var timeZoneAbbreviations: [String] { return TimeZone.knownTimeZoneIdentifiers }
        print(timeZoneAbbreviations)
    }
    
    
}
//let notifyDateFormatter = NotifyDateFormatter()
//
//let cities: [String] = ["Europe/Samara", "Europe/Moscow"]
////        print(notifyDateFormatter.convertDate(dateString: "02 Августа 2022"))
////        print(notifyDateFormatter.convertDateCity(dateString: "02 Августа 2022 13:15", city: "Samara"))
//print(notifyDateFormatter.convertDateCity(dateString: "02 Августа 2022 13:15", city: cities))
extension Date{
    func asString(format: String = "yy/MM/dd HH:mm",
                  for identifier: Calendar.Identifier = .gregorian) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: identifier)
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
