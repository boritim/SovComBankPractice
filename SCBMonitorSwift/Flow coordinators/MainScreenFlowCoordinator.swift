//
//  MainScreenFlowCoordinator.swift
//  SCBMonitorSwift
//
//  Created by ANTON DOBRYNIN on 05.07.2022.
//

import UIKit

protocol MainScreenFlowCoordinatorHandler: AnyObject {
    func openCalendar()
    func openNotif()
    func openGuide()
    func openPersonalPage()
    func didSuccessLogin()
    func openEmployessButton()
    func openDeviceRentButton()
    func openTimerButton()
}

final class MainScreenFlowCoordinator: Coordinator {
    
    var childDependencies: CoordinatorDependencies
    weak var flowListener: CoordinatorFlowListener?
    weak var navigationController: UINavigationController?
    
    weak var mainVC: MainScreenViewController?
    
    init(navigationController: UINavigationController?,
         childDependencies: CoordinatorDependencies = DefaultCoordinatorDependencies(),
         flowListener: CoordinatorFlowListener?) {
        
        self.navigationController = navigationController
        self.childDependencies = childDependencies
        self.flowListener = flowListener
    }
    
    func start() {
        
        let mainVC = MainScreenViewController()
        self.mainVC  = mainVC
        mainVC.mainScreenCoordinatorHandler = self
        navigationController?.pushViewController(mainVC, animated: false)
    }
    
}

// MARK: - CoordinatorFlowListener
extension MainScreenFlowCoordinator: CoordinatorFlowListener {
    func onFlowFinished(coordinator: Coordinator) {
        childDependencies.remove(dependency: coordinator)
        
//        flowListener?.onFlowFinished(coordinator: coordinator)
    }
}

// MARK: - MainScreenFlowCoordinatorHandler
extension MainScreenFlowCoordinator: MainScreenFlowCoordinatorHandler {
    func openCalendar() {
        onFlowFinished(coordinator: self)
        let calendarCoordinator = CalendarFlowCoordinator(navigationController:
                                                          navigationController,
                                                          flowListener: self)
        childDependencies.add(dependency: calendarCoordinator)
        calendarCoordinator.start()
    }
    
    func openPersonalPage() {
        onFlowFinished(coordinator: self)
        let personalPageCoordinator = PersonalPageFlowCoordinator(navigationController:
                                                            navigationController,
                                                            flowListener: self)
        childDependencies.add(dependency: personalPageCoordinator)
        personalPageCoordinator.start()
    }
    
    func openGuide() {
        onFlowFinished(coordinator: self)
        let guideVC = GuideScreenViewController()
        navigationController?.pushViewController(guideVC, animated: true)
    }
    
    func openNotif() {
        onFlowFinished(coordinator: self)
        let notifyScreenCoordinator = NotifyScreenFlowCoordinator(navigationController:
                                                              navigationController,
                                                              flowListener: self)
        childDependencies.add(dependency: notifyScreenCoordinator)
        notifyScreenCoordinator.start()
    }
    
    func didSuccessLogin() {
//        UserDefaults.standard.set(true, forKey: "isUserLogged")
        
        onFlowFinished(coordinator: self)
        let authScreenCoordinator = AuthScreenFlowCoordinator(navigationController:
                                                              navigationController,
                                                              flowListener: self)
        childDependencies.add(dependency: authScreenCoordinator)
        authScreenCoordinator.start()
    }
    
    func openEmployessButton() {
        onFlowFinished(coordinator: self)
        let employeesScreenCoordinator = EmployeesScreenFlowCoordinator(navigationController:
                                                              navigationController,
                                                              flowListener: self)
        childDependencies.add(dependency: employeesScreenCoordinator)
        employeesScreenCoordinator.start()
    }
    
    func openDeviceRentButton() {
        onFlowFinished(coordinator: self)
        let devideRentalVC = DeviceRentalMainViewController()
        navigationController?.pushViewController(devideRentalVC, animated: true)
    }
    
    func openTimerButton() {
        onFlowFinished(coordinator: self)
        let timerFlowCoordinator = TimerScreenFlowCoordinator(navigationController:
                                                              navigationController,
                                                              flowListener: self)
        childDependencies.add(dependency: timerFlowCoordinator)
        timerFlowCoordinator.start()
    }
}
