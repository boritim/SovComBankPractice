//
//  PersonalPageModel.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 13.07.2022.
//

import Foundation

struct PDModel {
    let id: Int
    let type: Types
    var body: String
//    let name: String
//    let employee: String
//    let phone: String
//    let email: String
//    let devices: String
//    let skills: String
}

enum Types: Int {
    case one = 1, two, three, four, five
}

let personalCellIdentifier = "PDCell"
