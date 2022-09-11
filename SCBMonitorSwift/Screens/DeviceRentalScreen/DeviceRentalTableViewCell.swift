//
//  DeviceRentalViewController.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 07.07.22.
//

import UIKit

final class DeviceRentalTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "deviceRentalTableViewCell"
    
    // MARK: - Private properties
    private lazy var containterView: UIView = {
        let containerView = UIView()
        containerView.layer.borderColor = MColors.selago.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 10
        return containerView
    }()
    
    private lazy var deviceImageView: UIImageView = {
        let deviceImageView = UIImageView()
        return deviceImageView
    }()
    
    private lazy var deviceTitleLabel: UILabel = {
        let deviceTitleLabel = UILabel()
        deviceTitleLabel.textColor = MColors.maco
        deviceTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        deviceTitleLabel.sizeToFit()
        return deviceTitleLabel
    }()
    
    private lazy var deviceStatusLabel: UILabel = {
        let deviceStatusLabel = UILabel()
        deviceStatusLabel.textColor = MColors.silver
        deviceStatusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return deviceStatusLabel
    }()
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(by model: DeviceRentalModel) {
        deviceImageView.image = model.image
        deviceTitleLabel.text = model.title
        deviceStatusLabel.text = model.subtitle
    }
    
    func deviceStatusDidChanged(isBusy: Bool) {
        containterView.backgroundColor = isBusy ? MColors.whisper : MColors.white
    }
}

// MARK: - Private
private extension DeviceRentalTableViewCell {
    func setupContentView() {
        
        containterView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containterView)
        NSLayoutConstraint.activate([
            containterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: 8),
            contentView.rightAnchor.constraint(equalTo: containterView.rightAnchor, constant: 16)
        ])
        
        deviceImageView.translatesAutoresizingMaskIntoConstraints = false
        containterView.addSubview(deviceImageView)
        NSLayoutConstraint.activate([
            deviceImageView.topAnchor.constraint(equalTo: containterView.topAnchor, constant: 12),
            deviceImageView.leftAnchor.constraint(equalTo: containterView.leftAnchor, constant: 28),
            containterView.bottomAnchor.constraint(equalTo: deviceImageView.bottomAnchor, constant: 12)
        ])
        
        deviceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containterView.addSubview(deviceTitleLabel)
        NSLayoutConstraint.activate([
            deviceTitleLabel.topAnchor.constraint(equalTo: deviceImageView.topAnchor, constant: 4),
            deviceTitleLabel.leftAnchor.constraint(equalTo: deviceImageView.rightAnchor, constant: 28)
        ])

        deviceStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        containterView.addSubview(deviceStatusLabel)
        NSLayoutConstraint.activate([
            deviceStatusLabel.topAnchor.constraint(equalTo: deviceTitleLabel.bottomAnchor, constant: 12),
            deviceStatusLabel.leftAnchor.constraint(equalTo: deviceImageView.rightAnchor, constant: 28)
        ])
    }
}
