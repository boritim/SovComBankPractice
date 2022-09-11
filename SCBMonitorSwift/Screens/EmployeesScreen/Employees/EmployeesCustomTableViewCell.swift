//
//  EmployeesCustomTableViewCell.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 12.07.2022.
//

import UIKit

final class EmployeesCustomTableViewCell: UITableViewCell {
    
    static let reuseIdentitfier = "employeesCustomTableViewCell"
    
    // MARK: - Private properties
    private lazy var containterView: UIView = {
        let containerView = UIView()
        containerView.layer.borderColor = MColors.selago.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 10
        return containerView
    }()
    
    private lazy var employeeImageView: UIImageView = {
        let employeeImageView = UIImageView()
        employeeImageView.image = UIImage(named: "image")
        employeeImageView.contentMode = .scaleToFill
        return employeeImageView
    }()
    
    private lazy var employeeFullNameLabel: UILabel = {
        let employeeFullNameLabel = UILabel()
        employeeFullNameLabel.text = nil
        employeeFullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return employeeFullNameLabel
    }()
    
    private lazy var employeeProjectLabel: UILabel = {
        let employeeProjectLabel = UILabel()
        employeeProjectLabel.text = nil
        employeeProjectLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return employeeProjectLabel
    }()
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(by image: UIImage?, title: String, subtitle: String) {
        employeeImageView.image = image
        employeeFullNameLabel.text = title
        employeeProjectLabel.text = subtitle
    }
}

// MARK: - Private
private extension EmployeesCustomTableViewCell {
    func setupContentView() {
        
        let containerViewHeight: CGFloat = 85
        let employeeImageViewHeight: CGFloat = 60
        let employeeImageViewWidth: CGFloat = 60
        
        containterView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containterView)
        NSLayoutConstraint.activate([
            containterView.heightAnchor.constraint(greaterThanOrEqualToConstant: containerViewHeight),
            containterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: 8),
            contentView.rightAnchor.constraint(equalTo: containterView.rightAnchor, constant: 16)
        ])
        
        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        containterView.addSubview(employeeImageView)
        NSLayoutConstraint.activate([
            employeeImageView.heightAnchor.constraint(equalToConstant: employeeImageViewHeight),
            employeeImageView.widthAnchor.constraint(equalToConstant: employeeImageViewWidth),
            employeeImageView.centerYAnchor.constraint(equalTo: containterView.centerYAnchor),
            employeeImageView.leftAnchor.constraint(equalTo: containterView.leftAnchor, constant: 16)
        ])

        employeeFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containterView.addSubview(employeeFullNameLabel)
        NSLayoutConstraint.activate([
            employeeFullNameLabel.topAnchor.constraint(equalTo: employeeImageView.topAnchor, constant: 4),
            employeeFullNameLabel.leftAnchor.constraint(equalTo: employeeImageView.rightAnchor, constant: 16)
        ])

        employeeProjectLabel.translatesAutoresizingMaskIntoConstraints = false
        containterView.addSubview(employeeProjectLabel)
        NSLayoutConstraint.activate([
            employeeProjectLabel.topAnchor.constraint(equalTo: employeeFullNameLabel.bottomAnchor, constant: 12),
            employeeProjectLabel.leftAnchor.constraint(equalTo: employeeImageView.rightAnchor, constant: 16)
        ])
    }
}
