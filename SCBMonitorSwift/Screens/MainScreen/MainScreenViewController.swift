//
//  MainScreenViewController.swift
//  SCBMonitorSwift
//
//  Created by ANTON DOBRYNIN on 05.07.2022.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    weak var mainScreenCoordinatorHandler: MainScreenFlowCoordinatorHandler?
    
    // MARK: - Private Properties
    private let defaultButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Логин", for: .normal)
        return button
    }()
    private let notifButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Уведомления", for: .normal)
        return button
    }()
    private let guideButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Инф. для новичков", for: .normal)
        return button
    }()
    private let personalProfileButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Личный кабинет", for: .normal)
        return button
    }()
    private let calendarButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Сводная", for: .normal)
        return button
    }()
    private let employeesScreenButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Сотрудники", for: .normal)
        return button
    }()
    private let timerScreenButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Таймер", for: .normal)
        return button
    }()
    private let deviceRentalButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Аренда устройств", for: .normal)
        return button
    }()
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Главное меню"
        view.backgroundColor = MColors.white
        
        setupButtons()
    }
    // MARK: - Objc
    @objc func buttonDidTap() {
        // after business logic
        mainScreenCoordinatorHandler?.didSuccessLogin()
    }
    
    @objc func notifDidTap() {
        mainScreenCoordinatorHandler?.openNotif()
    }
    
    @objc func guideDidTap() {
        mainScreenCoordinatorHandler?.openGuide()
    }
    
    @objc func personalPageDidTap() {
        mainScreenCoordinatorHandler?.openPersonalPage()
    }
    
    @objc func calendarDidTap() {
        mainScreenCoordinatorHandler?.openCalendar()
    }
    
    @objc func employeesButtonPressed() {
        mainScreenCoordinatorHandler?.openEmployessButton()
    }
    
    @objc func deviceRentalButtonPressed() {
        mainScreenCoordinatorHandler?.openDeviceRentButton()
    }
    
    @objc func timerButtonPressed() {
        mainScreenCoordinatorHandler?.openTimerButton()
    }
    
    // MARK: - Setup Buttons
    func setupButtons() {
        defaultButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        view.addSubview(defaultButton)
        
        NSLayoutConstraint.activate([
            defaultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            defaultButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            defaultButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: defaultButton.rightAnchor, constant: 16)
        ])
        
        notifButton.addTarget(self, action: #selector(notifDidTap), for: .touchUpInside)
        view.addSubview(notifButton)
        
        NSLayoutConstraint.activate([
            notifButton.topAnchor.constraint(equalTo: defaultButton.bottomAnchor, constant: 20),
            notifButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: notifButton.rightAnchor, constant: 16)
        ])
        
        guideButton.addTarget(self, action: #selector(guideDidTap), for: .touchUpInside)
        view.addSubview(guideButton)
        
        NSLayoutConstraint.activate([
            guideButton.topAnchor.constraint(equalTo: notifButton.bottomAnchor, constant: 20),
            guideButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: guideButton.rightAnchor, constant: 16)
        ])
        
        personalProfileButton.addTarget(self, action: #selector(personalPageDidTap), for: .touchUpInside)
        view.addSubview(personalProfileButton)
        
        NSLayoutConstraint.activate([
            personalProfileButton.topAnchor.constraint(equalTo: guideButton.bottomAnchor, constant: 20),
            personalProfileButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: personalProfileButton.rightAnchor, constant: 16)
        ])
        
        calendarButton.addTarget(self, action: #selector(calendarDidTap), for: .touchUpInside)
        view.addSubview(calendarButton)
        
        NSLayoutConstraint.activate([
            calendarButton.topAnchor.constraint(equalTo: personalProfileButton.bottomAnchor, constant: 20),
            calendarButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: calendarButton.rightAnchor, constant: 16)
        ])
        
        timerScreenButton.addTarget(self, action: #selector(timerButtonPressed), for: .touchUpInside)
        view.addSubview(timerScreenButton)
        
        NSLayoutConstraint.activate([
            defaultButton.topAnchor.constraint(equalTo: timerScreenButton.bottomAnchor, constant: 20),
            timerScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: timerScreenButton.rightAnchor, constant: 16)
        ])
        
        deviceRentalButton.addTarget(self, action: #selector(deviceRentalButtonPressed), for: .touchUpInside)
        view.addSubview(deviceRentalButton)
        
        NSLayoutConstraint.activate([
            timerScreenButton.topAnchor.constraint(equalTo: deviceRentalButton.bottomAnchor, constant: 20),
            deviceRentalButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: deviceRentalButton.rightAnchor, constant: 16)
        ])
        
        employeesScreenButton.addTarget(self, action: #selector(employeesButtonPressed), for: .touchUpInside)
        view.addSubview(employeesScreenButton)

        NSLayoutConstraint.activate([
            deviceRentalButton.topAnchor.constraint(equalTo: employeesScreenButton.bottomAnchor, constant: 20),
            employeesScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: employeesScreenButton.rightAnchor, constant: 16)
        ])
    }
}
