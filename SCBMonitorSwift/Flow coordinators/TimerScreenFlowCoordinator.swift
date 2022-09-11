//
//  TimerScreenFlowCoordinator.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 19.07.2022.
//

import UIKit

protocol TimerScreemFlowCoordinatorHandler: AnyObject {
}

final class TimerScreenFlowCoordinator: Coordinator {
    
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
        
        let timerVC = TimerViewController()
        timerVC.timerScreenFlowCoordinatorHandler = self
        navigationController?.pushViewController(timerVC, animated: true)
    }
    
}

// MARK: - CoordinatorFlowListener
extension TimerScreenFlowCoordinator: CoordinatorFlowListener {
    
    func onFlowFinished(coordinator: Coordinator) {
        childDependencies.remove(dependency: coordinator)
        flowListener?.onFlowFinished(coordinator: coordinator)
    }
}

// MARK: - MainScreenFlowCoordinatorHandler
extension TimerScreenFlowCoordinator: TimerScreemFlowCoordinatorHandler {
}
