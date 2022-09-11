//
//  EmployeesTableViewHeaderView.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 12.07.2022.
//

import UIKit

protocol EmployeesTableViewHeaderViewDelegate: AnyObject {
    func expandedSection(button: UIButton)
}

final class EmployeesTableViewHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "employeesTableViewHeaderView"
    
    weak var delegate: EmployeesTableViewHeaderViewDelegate?
    
    // MARK: - Private properties
    private lazy var specialityLabel: UILabel = {
        let specialityLabel = UILabel()
        specialityLabel.text = nil
        specialityLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        specialityLabel.sizeToFit()
        return specialityLabel
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(systemName: "chevron.down")
        arrowImageView.tintColor = .label
        arrowImageView.contentMode = .scaleAspectFill
        return arrowImageView
    }()
    
    private lazy var headerButton: UIButton = {
        let headerButton = UIButton()
        return headerButton
    }()
    
    // MARK: - Life cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(by title: String, section: Int) {
        specialityLabel.text = title
        headerButton.tag = section
    }
    
    func rotateImage(_ isExpanded: Bool) {
        arrowImageView.transform = isExpanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : CGAffineTransform(rotationAngle: CGFloat.zero)
    }
}

// MARK: - Private
private extension EmployeesTableViewHeaderView {
    func setupUI() {
        
        specialityLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(specialityLabel)
        NSLayoutConstraint.activate([
            specialityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            specialityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightAnchor.constraint(equalTo: arrowImageView.rightAnchor, constant: 16)
        ])
        
        headerButton.addTarget(self, action: #selector(headerButtonDidTapped), for: .touchUpInside)
                
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerButton)
        NSLayoutConstraint.activate([
            headerButton.topAnchor.constraint(equalTo: topAnchor),
            headerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: headerButton.bottomAnchor),
            rightAnchor.constraint(equalTo: headerButton.rightAnchor, constant: 16)
        ])
    }
    
    // MARK: - Objc
    @objc func headerButtonDidTapped(sender: UIButton) {
        delegate?.expandedSection(button: sender)
    }
}
