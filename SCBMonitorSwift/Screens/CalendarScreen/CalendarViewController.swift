//
//  CalendarViewController.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 18.07.2022.
//

import UIKit

class CalendarViewController: UIViewController {
    
    weak var calendarFlowCoordinatorHandler: CalendarFlowCoordinatorHandler?

    // MARK: - Private Properties
    private let tableView = UITableView()
    
    private var calendarData = [CalendarModel(id: 1,
                                              date: "14.02.2022-20.02.2022"),
                                CalendarModel(id: 2,
                                              date: "07.02.2022-13.02.2022"),
                                CalendarModel(id: 3,
                                              date: "31.01.2022-06.02.2022")]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Сводная"
        view.backgroundColor = .white
        
        setupTableView()

    }
}

// MARK: - Setup UI
private extension CalendarViewController {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CalendarCell.self, forCellReuseIdentifier: calendarCellIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor)
        ])
    }
}

// MARK: - TableView Metods
extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: calendarCellIdentifier, for: indexPath) as! CalendarCell
        let calendarData = calendarData[indexPath.item]
        cell.configure(calendarData)
        cell.selectionStyle = .none
        cell.calendarDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
// MARK: - CalendarCellDelegate
extension CalendarViewController: CalendarCellDelegate {
    func openDetailCalendar() {
        calendarFlowCoordinatorHandler?.openDetailCalendar()
    }
}
