//
//  DetailCalendarViewController.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 18.07.2022.
//

import UIKit

class DetailCalendarViewController: UIViewController {
    
    // MARK: - Private Properties
    private let tableView = UITableView()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "14.02.2022-20.02.2022"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Редактировать", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    let detailCalDate = [DetailCallendarModel(id: 1, day: "Дни", timer: "По таймеру", turniket: "По турникету"),
                         DetailCallendarModel(id: 2, day: "14 | Пн", timer: "09:00", turniket: "08:00"),
                         DetailCallendarModel(id: 3, day: "15 | Вт", timer: "09:00", turniket: "-"),
                         DetailCallendarModel(id: 4, day: "16 | Ср", timer: "09:00", turniket: "08:00"),
                         DetailCallendarModel(id: 5, day: "17 | Чт", timer: "09:00", turniket: "08:00"),
                         DetailCallendarModel(id: 6, day: "18 | Пт", timer: "09:00", turniket: "08:00"),
                         DetailCallendarModel(id: 7, day: "19 | Сб", timer: "-", turniket: "-"),
                         DetailCallendarModel(id: 8, day: "20 | Вс", timer: "-", turniket: "-")]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
    }
}

// MARK: - Setup View
private extension DetailCalendarViewController {
    func setupView() {
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(DetailCalendarTableViewCell.self, forCellReuseIdentifier: detailCalendarCell)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 18),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 312),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor)
        ])
        
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40)
            
        ])
    }
}

// MARK: - Tableview Metods
extension DetailCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailCalDate.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCalendarCell, for: indexPath) as! DetailCalendarTableViewCell
        let detСalendarData = detailCalDate[indexPath.item]
        cell.configure(detСalendarData)
        cell.selectionStyle = .none
//        cell.calendarDelegate = self
        return cell
    }
}
