//
//  TableViewCell.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 08.07.2022.
//

import UIKit

final class NotifyCell: UITableViewCell {
    
    // MARK: - Private Properties
    private let userDefault = UserDefaults.standard
    
    private var cellId = Int()
    
    private var conteiner: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = MColors.whisper.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    private var cubeView: UIView = {
        let view = UIView()
        view.backgroundColor = MColors.heliotrope
        view.layer.cornerRadius = 10
        return view
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConteiner() // Conteiner + cube
        setupLabel() // 2 Labels
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(_ model: NotifyModel) {
        cellId = model.id
        titleLabel.text = model.title
        bodyLabel.text = model.body
        dateLabel.text = model.date
//            .asString()
        conteiner.backgroundColor = model.isRead ? .white : MColors.selago
    }
}

// MARK: - Setup Cell
private extension NotifyCell {
    
    func setupConteiner() {
        contentView.addSubview(conteiner)
        conteiner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conteiner.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: conteiner.bottomAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: conteiner.rightAnchor, constant: 16)
        ])
        
        conteiner.addSubview(cubeView)
        cubeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cubeView.heightAnchor.constraint(equalToConstant: 55),
            cubeView.widthAnchor.constraint(equalToConstant: 62),
            cubeView.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 20),
            cubeView.leftAnchor.constraint(equalTo: conteiner.leftAnchor, constant: 16)
        ])
        cubeView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: cubeView.topAnchor, constant: 11.5),
            dateLabel.leftAnchor.constraint(equalTo: cubeView.leftAnchor, constant: 10),
            cubeView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11.5),
            cubeView.rightAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 10)
        ])
    }
    
    func setupLabel () {
        conteiner.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: cubeView.rightAnchor, constant: 16),
            conteiner.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 57),
            conteiner.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16)
        ])
        conteiner.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodyLabel.leftAnchor.constraint(equalTo: cubeView.rightAnchor, constant: 16),
            conteiner.bottomAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 20),
            conteiner.rightAnchor.constraint(equalTo: bodyLabel.rightAnchor, constant: 16)
        ])
    }
}
