//
//  MainCoordinator.swift
//  SCBMonitorSwift
//
//  Created by ANTON DOBRYNIN on 05.07.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childDependencies: CoordinatorDependencies { get }
    var navigationController: UINavigationController? { get set }
    
    func start()
}

protocol CoordinatorFlowListener: AnyObject {
    func onFlowFinished(coordinator: Coordinator)
}

final class MainCoordinator: Coordinator {
    
    private let userDefault = UserDefaults.standard
    
    var childDependencies: CoordinatorDependencies
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController,
         childDependencies: CoordinatorDependencies = DefaultCoordinatorDependencies()) {
        self.navigationController = navigationController
        self.childDependencies = childDependencies
    }
    
    func start() {
        
//        let isUserLogged = self.userDefault.bool(forKey: "isUserLogged")
//
//        switch isUserLogged {
//        case true:
            let mainScreenCoordinator = MainScreenFlowCoordinator(navigationController:
                                                                  navigationController,
                                                                  flowListener: self)
            childDependencies.add(dependency: mainScreenCoordinator)
            mainScreenCoordinator.start()
//        case false:
//            let authScreenCoordinator = AuthScreenFlowCoordinator(navigationController:
//                                                                  navigationController,
//                                                                  flowListener: self)
//            childDependencies.add(dependency: authScreenCoordinator)
//            authScreenCoordinator.start()
        //}
    }
}

extension MainCoordinator: CoordinatorFlowListener {
    
    func onFlowFinished(coordinator: Coordinator) {
        childDependencies.remove(dependency: coordinator)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        
        let mainScreen = MainScreenViewController()
    
        window.rootViewController = mainScreen
        window.makeKeyAndVisible()
    }
}
