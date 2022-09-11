//
//  PersonalPageFlowCoordinator.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 14.07.2022.
//

import UIKit

protocol PersonalPageCoordinatorHandler: AnyObject {
    func openEditPopup()
}

class PersonalPageFlowCoordinator: Coordinator {

    var childDependencies: CoordinatorDependencies
    weak var flowListener: CoordinatorFlowListener?
    weak var navigationController: UINavigationController?
    
    var personalViewController: PersonalPageViewController?

    init(navigationController: UINavigationController?,
         childDependencies: CoordinatorDependencies = DefaultCoordinatorDependencies(),
         flowListener: CoordinatorFlowListener?) {

        self.navigationController = navigationController
        self.childDependencies = childDependencies
        self.flowListener = flowListener
    }

    func start() {
        personalViewController = PersonalPageViewController()
        personalViewController?.personalPageCoordinatorHandler = self
        navigationController?.pushViewController(personalViewController!, animated: true)
    }
}

// MARK: - CoordinatorFlowListener
extension PersonalPageFlowCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        childDependencies.remove(dependency: coordinator)
    }
}

// MARK: - PersonalPageCoordinatorHandler
extension PersonalPageFlowCoordinator: PersonalPageCoordinatorHandler {
    func openEditPopup() {
        let popUpVC = PersonalPagePopupViewController()
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.delegatePopUp = self
        personalViewController?.present(popUpVC, animated: false)
    }
}
extension PersonalPageFlowCoordinator: PersonalPopUpDelegate {
    func saveData(_ data: String) {
        personalViewController?.saveData(data)
    }
}
