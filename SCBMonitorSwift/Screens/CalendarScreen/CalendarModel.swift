//
//  CalendarModel.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 18.07.2022.
//

import Foundation

struct CalendarModel {
    let id: Int
    let date: String
//    let body: String
//    let isRead: Bool
}

struct CalCollectionModel {
    let id: Int
    let day: String
    let time: String
}

struct DetailCallendarModel {
    let id: Int
    let day: String
    let timer: String
    let turniket: String
}

let calendarCellIdentifier = "CalendarCell"

let calCollectionIdentifier = "CalCollectionCell"

let detailCalendarCell = "DetailCalendarCell"
