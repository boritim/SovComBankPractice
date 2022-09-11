//
//  PersonalPageViewController.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 12.07.2022.
//

import UIKit

final class PersonalPageViewController: UIViewController {
    
    weak var personalPageCoordinatorHandler: PersonalPageCoordinatorHandler?

    // MARK: - Private Properties
    private let tableView = UITableView()
    
    private var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    private var avatarIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "userMock-icon")
        return icon
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Петрова Мария Александровна"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    private var employeeLabel: UILabel = {
        let label = UILabel()
        label.text = "UX/UI Дизайнер"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    private let exitButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("Выйти", for: .normal)
        return button
    }()
        
    private var personalData = [PDModel(id: 1, type: Types.one, body: "28.06.2000"),
                                PDModel(id: 2, type: Types.two, body: "+7 (900) 600-04-81"),
                                PDModel(id: 3, type: Types.three, body: "mariyaivanova@sovcombank.ru"),
                                PDModel(id: 4, type: Types.four, body: "Mac mini  K390092338,  Монитор Lenovo  27 дюймов  K390096131 Клавиатура Apple, мышка Apple, iphone14"),
                                PDModel(id: 5, type: Types.five, body: "Figma, Sketch, Photoshop, Illustrator")]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MColors.selago
        
        setupBottomView()
        setupTopView()
        
    }
    // MARK: - Obj
    @objc func buttonDidTap() {
        print("Exit Button")
    }
}
// MARK: - Setup UI
private extension PersonalPageViewController {
    
    func setupTopView() {
        view.addSubview(avatarIcon)
        avatarIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 67),
            avatarIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: 300),
            
            nameLabel.topAnchor.constraint(equalTo: avatarIcon.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(employeeLabel)
        employeeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            employeeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 14),
            employeeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupBottomView() {
        
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: view.topAnchor, constant: 294),
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: bottomView.rightAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(PersonalDataCell.self, forCellReuseIdentifier: personalCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: bottomView.leftAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 186),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor)
        ])
        
        view.addSubview(exitButton)
        exitButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            view.rightAnchor.constraint(equalTo: exitButton.rightAnchor, constant: 20)
        ])
    }
}

// MARK: - TableView Metods
extension PersonalPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    personalCellIdentifier,
                                                 for: indexPath) as! PersonalDataCell
        let personalData = personalData[indexPath.item]
        cell.configure(personalData)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - PersonalDataCellDelegate
extension PersonalPageViewController: PersonalDataCellDelegate {
    func openEditPopup() {
        personalPageCoordinatorHandler?.openEditPopup()
    }
}

// MARK: - PersonalPopUpDelegate
extension PersonalPageViewController {
    func saveData(_ data: String) {
        personalData[4].body = data
        let indexPath = IndexPath(item: 4, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
