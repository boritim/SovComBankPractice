//
//  PersonalAreaAdditionalInfoView.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 11.07.2022.
//

import UIKit

final class PersonalAreaAdditionalInfoView: UIView {

    // MARK: - Private properties
    private lazy var birthdayInformationView: EmployeeCustomInformationView = {
        let birthdayInformationView = EmployeeCustomInformationView()
        return birthdayInformationView
    }()
    
    private lazy var phoneNumberInformationView: EmployeeCustomInformationView = {
        let phoneNumberInformationView = EmployeeCustomInformationView()
        return phoneNumberInformationView
    }()
    
    private lazy var skillsInformationView: EmployeeCustomInformationView = {
        let skillsInformationView = EmployeeCustomInformationView()
        return skillsInformationView
    }()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        backgroundColor = .systemBackground
        
        configureInformationViews()
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private
private extension PersonalAreaAdditionalInfoView {
    
    func configureInformationViews() {
        birthdayInformationView.configure(by: PersonalAreaInformationModel(image: UIImage(named: "phone"),
                                                                           title: "Phone number", description: "+7900909090"))
        phoneNumberInformationView.configure(by: PersonalAreaInformationModel(image: UIImage(named: "cake"),
                                                                              title: "Birtday date", description: "28.06.2000"))
        skillsInformationView.configure(by: PersonalAreaInformationModel(image: UIImage(named: "suitcase"),
                                                                         title: "Skills", description: "Figma, Sketch, Photoshop"))
    }
    
    func setupUI() {
        
        let informationViewHeight: CGFloat = 60
        
        birthdayInformationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(birthdayInformationView)
        NSLayoutConstraint.activate([
            birthdayInformationView.heightAnchor.constraint(equalToConstant: informationViewHeight),
            
            birthdayInformationView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            birthdayInformationView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            rightAnchor.constraint(equalTo: birthdayInformationView.rightAnchor, constant: 16),
        ])
        
        phoneNumberInformationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneNumberInformationView)
        NSLayoutConstraint.activate([
            phoneNumberInformationView.heightAnchor.constraint(equalToConstant: informationViewHeight),
            
            phoneNumberInformationView.topAnchor.constraint(equalTo: birthdayInformationView.bottomAnchor, constant: 16),
            phoneNumberInformationView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            rightAnchor.constraint(equalTo: phoneNumberInformationView.rightAnchor, constant: 16),
        ])
        
        skillsInformationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(skillsInformationView)
        NSLayoutConstraint.activate([
            skillsInformationView.heightAnchor.constraint(equalToConstant: informationViewHeight),
            
            skillsInformationView.topAnchor.constraint(equalTo: phoneNumberInformationView.bottomAnchor, constant: 16),
            skillsInformationView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            rightAnchor.constraint(equalTo: skillsInformationView.rightAnchor, constant: 16),
        ])
    }
}
