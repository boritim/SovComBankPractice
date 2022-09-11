//
//  AuthScreenFlowCoordinator.swift
//  SCBMonitorSwift
//
//  Created by ANTON DOBRYNIN on 05.07.2022.
//

import UIKit

protocol AuthScreenFlowCoordinatorHandler: AnyObject {
    func didSuccessLogin()
    func presentAuthModalViewController()
    func dismissAuthModalViewController()
}

final class AuthScreenFlowCoordinator: Coordinator {
    
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
        let authVC = AuthViewController()
        authVC.authScreenFlowCoordinatorHandler = self
        navigationController?.pushViewController(authVC, animated: true)
    }
}

// MARK: - CoordinatorFlowListener
extension AuthScreenFlowCoordinator: CoordinatorFlowListener {
    
    func onFlowFinished(coordinator: Coordinator) {
        childDependencies.remove(dependency: coordinator)
        
//        flowListener?.onFlowFinished(coordinator: coordinator)
    }
}

// MARK: - AuthScreenFlowCoordinatorHandler
extension AuthScreenFlowCoordinator: AuthScreenFlowCoordinatorHandler {
    
    func didSuccessLogin() {
        UserDefaults.standard.set(true, forKey: "isUserLogged")
        
        onFlowFinished(coordinator: self)
        let mainScreenCoordinator = MainScreenFlowCoordinator(navigationController:
                                                              navigationController,
                                                              flowListener: self)
        childDependencies.add(dependency: mainScreenCoordinator)
        mainScreenCoordinator.start()
    }
    
    func presentAuthModalViewController() {
        let authModalViewController = AuthModalViewController()
        authModalViewController.authScreenFlowCoordinatorHandler = self
        authModalViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.present(authModalViewController, animated: true)
    }
    
    func dismissAuthModalViewController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
