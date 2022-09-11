//
//  PersonalAreaViewController.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 11.07.2022.
//

import UIKit

final class PersonalAreaViewController: UIViewController {
    
    // MARK: - Private properties
    private lazy var headerView: PersonalAreaHeaderView = {
        let headerView = PersonalAreaHeaderView()
        return headerView
    }()
    
    private lazy var additionalInformationView: PersonalAreaAdditionalInfoView = {
        let additionalInformationView = PersonalAreaAdditionalInfoView()
        return additionalInformationView
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupUI()
    }
    
    // MARK: - Public
    func configureHeaderView(by model: EmployeeCellViewModel) {
        headerView.configure(by: model)
    }
}

// MARK: - Private
private extension PersonalAreaViewController {
    func setupUI() {
        
        let headerViewHeight: CGFloat = 275
                
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: headerViewHeight),
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.rightAnchor.constraint(equalTo: headerView.rightAnchor)
        ])
        
        additionalInformationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(additionalInformationView)
        NSLayoutConstraint.activate([
            headerView.bottomAnchor.constraint(equalTo: additionalInformationView.topAnchor, constant: 16),
            additionalInformationView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: additionalInformationView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: additionalInformationView.rightAnchor)
        ])
    }
}
