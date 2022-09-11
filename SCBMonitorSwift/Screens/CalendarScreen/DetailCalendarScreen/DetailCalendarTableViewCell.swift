//
//  DetailCalendarTableViewCell.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 18.07.2022.
//

import UIKit

class DetailCalendarTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Дни"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "По таймеру"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let turniketLabel: UILabel = {
        let label = UILabel()
        label.text = "По турникету"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let conteiner: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = MColors.whisper.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let verticalLabel1: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    private let verticalLabel2: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        //        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(_ model: DetailCallendarModel) {
        if model.id == 1 {
            conteiner.layer.borderWidth = 1
            conteiner.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            conteiner.layer.borderColor = MColors.whisper.cgColor
            conteiner.layer.cornerRadius = 10
            conteiner.backgroundColor = MColors.heliotrope
            
            dayLabel.text = model.day
            timerLabel.text = model.timer
            turniketLabel.text = model.turniket
        } else if model.id == 8 {
            conteiner.layer.borderWidth = 1
            conteiner.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            conteiner.layer.borderColor = MColors.whisper.cgColor
            conteiner.layer.cornerRadius = 10
            conteiner.backgroundColor = MColors.whisper
            
            dayLabel.text = model.day
            timerLabel.text = model.timer
            turniketLabel.text = model.turniket
        } else {
            if model.id%2 == 0 {
                conteiner.backgroundColor = MColors.whisper
            }
            conteiner.layer.borderWidth = 1
            conteiner.layer.borderColor = MColors.whisper.cgColor
            conteiner.layer.cornerRadius = 0
            
            dayLabel.text = model.day
            timerLabel.text = model.timer
            turniketLabel.text = model.turniket
        }
    }
}

// MARK: - Setup Cell
private extension DetailCalendarTableViewCell {
    func setupCell() {
        contentView.addSubview(conteiner)
        conteiner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conteiner.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: conteiner.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: conteiner.rightAnchor, constant: 16)
        ])
        
        conteiner.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let centerConstraint = contentView.frame.size.width/3/2
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 13),
            dayLabel.leftAnchor.constraint(equalTo: conteiner.leftAnchor, constant: centerConstraint),
            conteiner.bottomAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 13)
        ])
        
        conteiner.addSubview(verticalLabel1)
        conteiner.addSubview(verticalLabel2)
        verticalLabel1.translatesAutoresizingMaskIntoConstraints = false
        verticalLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalLabel1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            verticalLabel1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: (centerConstraint + 16) * 2),
            
            verticalLabel2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            verticalLabel2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: (-centerConstraint - 16) * 2)
        ])
        
        conteiner.addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 13),
            timerLabel.centerXAnchor.constraint(equalTo: conteiner.centerXAnchor)
        ])
        
        conteiner.addSubview(turniketLabel)
        turniketLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            turniketLabel.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 13),
            conteiner.rightAnchor.constraint(equalTo: turniketLabel.rightAnchor, constant: centerConstraint - 32),
            conteiner.bottomAnchor.constraint(equalTo: turniketLabel.bottomAnchor, constant: 13)
        ])
    }
}
