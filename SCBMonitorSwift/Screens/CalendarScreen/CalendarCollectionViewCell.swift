//
//  CalendarCollectionViewCell.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 18.07.2022.
//

import UIKit

class CalendarCollectionCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "ПН"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "09:00"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(_ model: CalCollectionModel) {
        dayLabel.text = model.day
        timeLabel.text = model.time
    }
}

// MARK: - Setup Cell
private extension CalendarCollectionCell {
    func setupView() {
        contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor)
        ])
    }
}
