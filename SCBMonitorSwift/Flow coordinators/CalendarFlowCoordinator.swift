//
//  CalendarFlowCoordinator.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 18.07.2022.
//

import UIKit

protocol CalendarFlowCoordinatorHandler: AnyObject {
    func openDetailCalendar()
}

final class CalendarFlowCoordinator: Coordinator {
    
    var childDependencies: CoordinatorDependencies
    weak var flowListener: CoordinatorFlowListener?
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?,
         childDependencies: CoordinatorDependencies = DefaultCoordinatorDependencies(),
         flowListener: CoordinatorFlowListener?) {
        
        self.navigationController = navigationController
        self.childDependencies = childDependencies
        self.flowListener = flowListener
    }
    
    func start() {
        
        let CalendarVC = CalendarViewController()
        CalendarVC.calendarFlowCoordinatorHandler = self
        navigationController?.pushViewController(CalendarVC, animated: true)
    }
    
}

// MARK: - CoordinatorFlowListener
extension CalendarFlowCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        childDependencies.remove(dependency: coordinator)
        
//        flowListener?.onFlowFinished(coordinator: coordinator)
    }
}

// MARK: - CalendarFlowCoordinatorHandler
extension CalendarFlowCoordinator: CalendarFlowCoordinatorHandler {
    func openDetailCalendar() {
        let detailVC = DetailCalendarViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
