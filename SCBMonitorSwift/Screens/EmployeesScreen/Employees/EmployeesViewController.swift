//
//  EmployeesViewController.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 11.07.2022.
//

import UIKit

final class EmployeesViewController: UIViewController {
    
    weak var employeesScreenFlowCoordinatorHandler: EmployeesScreenFlowCoordinatorHandler?
    
    // MARK: - Private properties
    private lazy var employeesTableView: UITableView = {
        let employeesTableView = UITableView()
        employeesTableView.separatorStyle = .none
        return employeesTableView
    }()
    
    // Mocked data -> we can use it in model
    private var data: [EmployeesHeaderViewModel] = [
        EmployeesHeaderViewModel(titleText: "Проект менеджеры",
                                 employeeModels: [(EmployeeCellViewModel(id: 0, image: UIImage(named: "userMock-icon"), title: "Мария Петрова", subtitle: "Халенок")),
        (EmployeeCellViewModel(id: 1, image: UIImage(named: "userMock-icon"), title: "Татьяна Сидорова", subtitle: "Женский банк"))
                                                 ],
                                 isExpanded: false),
        EmployeesHeaderViewModel(titleText: "Дизайнеры",
                                 employeeModels: [(EmployeeCellViewModel(id: 1, image: UIImage(named: "userMock-icon"), title: "Ульяна Рожкова", subtitle: "Халенок")),
        (EmployeeCellViewModel(id: 2, image: UIImage(named: "userMock-icon"), title: "Дарья Сухумская", subtitle: "Женский банк"))
                                                 ],
                                 isExpanded: false),
        EmployeesHeaderViewModel(titleText: "Аналитики",
                                 employeeModels: [(EmployeeCellViewModel(id: 2, image: UIImage(named: "userMock-icon"), title: "Евангелина Сидникова", subtitle: "Халенок")),
        (EmployeeCellViewModel(id: 3, image: UIImage(named: "userMock-icon"), title: "Тамара Василькова", subtitle: "Женский банк"))
                                                 ],
                                 isExpanded: false),
        EmployeesHeaderViewModel(titleText: "Тестировщики",
                                 employeeModels: [(EmployeeCellViewModel(id: 3, image: UIImage(named: "userMock-icon"), title: "Юлия Смыр", subtitle: "Халенок")),
        (EmployeeCellViewModel(id: 4, image: UIImage(named: "userMock-icon"), title: "Пицунда Дранда", subtitle: "Женский банк"))],
                                 isExpanded: false),
        EmployeesHeaderViewModel(titleText: "Frontend-разработчики",
                                 employeeModels: [(EmployeeCellViewModel(id: 4, image: UIImage(named: "userMock-icon"), title: "Валентин Иванов", subtitle: "Женский банк")),
        (EmployeeCellViewModel(id: 5, image: UIImage(named: "userMock-icon"), title: "Олег Монгол", subtitle: "Финансовый помощник"))
                                                 ],
                                 isExpanded: false)
    ]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Сотрудники"
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
}

// MARK: - Private
private extension EmployeesViewController {
    func setupUI() {
        
        employeesTableView.tableFooterView = UIView()
        
        employeesTableView.delegate = self
        employeesTableView.dataSource = self
        
        employeesTableView.register(EmployeesCustomTableViewCell.self, forCellReuseIdentifier: EmployeesCustomTableViewCell.reuseIdentitfier)
        employeesTableView.register(EmployeesTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: EmployeesTableViewHeaderView.reuseIdentifier)
        
        employeesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(employeesTableView)
        employeesTableView.embed(in: view)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !data[section].isExpanded ? 0 : data[section].employeeModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeesCustomTableViewCell.reuseIdentitfier, for: indexPath) as! EmployeesCustomTableViewCell
        let model = data[indexPath.section].employeeModels[indexPath.row]
        cell.configure(by: model.image, title: model.title, subtitle: model.subtitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: EmployeesTableViewHeaderView.reuseIdentifier) as! EmployeesTableViewHeaderView
        header.configure(by: data[section].titleText, section: section)
        header.rotateImage(data[section].isExpanded)
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = data[indexPath.section].employeeModels[indexPath.row]
        employeesScreenFlowCoordinatorHandler?.goToPersonalAreaButtonTapped(with: EmployeeCellViewModel(id: cell.id, image: cell.image, title: cell.title, subtitle: cell.subtitle))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - EmployeesTableViewHeaderViewDelegate
extension EmployeesViewController: EmployeesTableViewHeaderViewDelegate {
    func expandedSection(button: UIButton) {
        let section = button.tag
        let isExpanded = data[section].isExpanded
        data[section].isExpanded = !isExpanded
        DispatchQueue.main.async {
            self.employeesTableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
}
