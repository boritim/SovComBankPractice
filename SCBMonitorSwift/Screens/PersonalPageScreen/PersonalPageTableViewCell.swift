//
//  PersonalPageTableViewCell.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 13.07.2022.
//

import UIKit

protocol PersonalDataCellDelegate: AnyObject {
    func openEditPopup()
}

final class PersonalDataCell: UITableViewCell {
    
    weak var delegate: PersonalDataCellDelegate?
    
    // MARK: - Private properties
    private var cellId = Int()
    
    private var conteiner: UIView = {
        let view = UIView()
        return view
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    private var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editInfo-icon"), for: .normal)
        return button
    }()
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(_ model: PDModel) {
        switch model.type {
        case .one:
            titleLabel.text = "Дата рождения"
            bodyLabel.text = model.body
        case .two:
            titleLabel.text = "Номер телефона"
            bodyLabel.text = model.body
        case .three:
            titleLabel.text = "Email"
            bodyLabel.text = model.body
        case .four:
            titleLabel.text = "Рабочие устройства"
            bodyLabel.text = model.body
        case .five:
            titleLabel.text = "Навыки"
            setupButton()
            if model.body.isEmpty {
                bodyLabel.text = "Добавьте свои навыки"
                bodyLabel.font = .systemFont(ofSize: 14)
                bodyLabel.textColor = .gray
            } else {
                bodyLabel.text = model.body
                bodyLabel.font = .systemFont(ofSize: 16)
                bodyLabel.textColor = .black
            }
        }
    }
    // MARK: - Obj
    @objc func buttonDidTap() {
        delegate?.openEditPopup()
    }
}
// MARK: - Private metods
private extension PersonalDataCell {
    
    func setupLabel () {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            bodyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 21),
            contentView.rightAnchor.constraint(equalTo: bodyLabel.rightAnchor, constant: 40)
        ])
    }
    
    func setupButton() {
        contentView.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        editButton.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            editButton.widthAnchor.constraint(equalToConstant: 20),
            editButton.heightAnchor.constraint(equalToConstant: 20),
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
//            contentView.bottomAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 23),
            contentView.rightAnchor.constraint(equalTo: editButton.rightAnchor, constant: 16)
        ])
    }
}
