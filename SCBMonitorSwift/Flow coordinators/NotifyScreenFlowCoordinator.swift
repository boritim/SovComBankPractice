//
//  NotifyScreenFlowCoordinator.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 09.07.2022.
//

//
//  MainScreenFlowCoordinator.swift
//  SCBMonitorSwift
//
//  Created by ANTON DOBRYNIN on 05.07.2022.
//

import UIKit

protocol NotifyScreenFlowCoordinatorHandler: AnyObject {
    func openNotifItem(_ model: NotifyModel)
}

final class NotifyScreenFlowCoordinator: Coordinator {
        
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
        let mainVC = NotifyScreenViewController()
        mainVC.notifyScreenCoordinatorHandler = self
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func openDetail(_ model: NotifyModel) {
        let mainVC = NotifyDetailViewController()
        mainVC.identification = model.id
        navigationController?.pushViewController(mainVC, animated: true)
    }
}

// MARK: - CoordinatorFlowListener
extension NotifyScreenFlowCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        childDependencies.remove(dependency: coordinator)
    }
}

// MARK: - MainScreenFlowCoordinatorHandler
extension NotifyScreenFlowCoordinator: NotifyScreenFlowCoordinatorHandler {
    func openNotifItem(_ model: NotifyModel) {
        onFlowFinished(coordinator: self)
        let mainVC = NotifyDetailViewController()
        mainVC.identification = model.id
        navigationController?.pushViewController(mainVC, animated: true)
        
    }
}
