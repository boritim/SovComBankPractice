//
//  PersonalAreaHeaderView.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 11.07.2022.
//

import UIKit

final class PersonalAreaHeaderView: UIView {
    
    // MARK: - Private properties
    private lazy var employeeImageView: UIImageView = {
        let employeeImageView = UIImageView()
        employeeImageView.image = UIImage(named: "userMock-icon")
        return employeeImageView
    }()
    
    private lazy var employeeFullNameLabel: UILabel = {
        let employeeFullNameLabel = UILabel()
        employeeFullNameLabel.textColor = MColors.mineShaft
        employeeFullNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        employeeFullNameLabel.text = "Татьяна Сидорова"
        return employeeFullNameLabel
    }()
    
    private lazy var employeeJobTitleLabel: UILabel = {
        let employeeJobTitleLabel = UILabel()
        employeeJobTitleLabel.textColor = MColors.maco
        employeeJobTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        employeeJobTitleLabel.text = "UX/UI Designer"
        return employeeJobTitleLabel
    }()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(cgColor: MColors.selago.cgColor)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(by model: EmployeeCellViewModel) {
        employeeImageView.image = model.image
        employeeFullNameLabel.text = model.title
    }
}

// MARK: - Private
private extension PersonalAreaHeaderView {
    
    func setupUI() {
        
        let employeeImageViewHeight: CGFloat = 80
        let employeeImageViewWidth: CGFloat = 80
        
        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(employeeImageView)
        NSLayoutConstraint.activate([
            employeeImageView.heightAnchor.constraint(equalToConstant: employeeImageViewHeight),
            employeeImageView.widthAnchor.constraint(equalToConstant: employeeImageViewWidth),
            
            employeeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            employeeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 48),
        ])
        
        employeeFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(employeeFullNameLabel)
        NSLayoutConstraint.activate([
            employeeFullNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            employeeFullNameLabel.topAnchor.constraint(equalTo: employeeImageView.bottomAnchor, constant: 20)
        ])
        
        employeeJobTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(employeeJobTitleLabel)
        NSLayoutConstraint.activate([
            employeeJobTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            employeeJobTitleLabel.topAnchor.constraint(equalTo: employeeFullNameLabel.bottomAnchor, constant: 16)
        ])
    }
}
