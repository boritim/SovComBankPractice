//
//  EmployeesScreenFlowCoordinator.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 13.07.2022.
//

import UIKit

protocol EmployeesScreenFlowCoordinatorHandler: AnyObject {
    func goToPersonalAreaButtonTapped(with model: EmployeeCellViewModel)
}

final class EmployeesScreenFlowCoordinator: Coordinator {
    
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
        
        let employeesVC = EmployeesViewController()
        employeesVC.employeesScreenFlowCoordinatorHandler = self
        navigationController?.pushViewController(employeesVC, animated: true)
    }
    
}

// MARK: - CoordinatorFlowListener
extension EmployeesScreenFlowCoordinator: CoordinatorFlowListener {
    
    func onFlowFinished(coordinator: Coordinator) {
        childDependencies.remove(dependency: coordinator)
        
        flowListener?.onFlowFinished(coordinator: coordinator)
    }
}

// MARK: - MainScreenFlowCoordinatorHandler
extension EmployeesScreenFlowCoordinator: EmployeesScreenFlowCoordinatorHandler {
    func goToPersonalAreaButtonTapped(with model: EmployeeCellViewModel) {
        let personalAreaViewController = PersonalAreaViewController()
        personalAreaViewController.configureHeaderView(by: model)
        navigationController?.pushViewController(personalAreaViewController, animated: true)
    }
}
