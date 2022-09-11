//
//  EmployeesHeaderViewModel.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 12.07.2022.
//

import UIKit

struct EmployeesHeaderViewModel {
    let titleText: String
    let employeeModels: [EmployeeCellViewModel]
    var isExpanded: Bool
}

struct EmployeeCellViewModel {
    let id: Int
    let image: UIImage?
    let title: String
    let subtitle: String
}
