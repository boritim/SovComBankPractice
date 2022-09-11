//
//  EmployeeCustomInformationView.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 11.07.2022.
//

import UIKit

final class EmployeeCustomInformationView: UIView {
    
    // MARK: - Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textView.textColor = MColors.maco
        textView.textAlignment = .left
        return textView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = MColors.osloGray
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return titleLabel
    }()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        textView.isUserInteractionEnabled = false
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(by model: PersonalAreaInformationModel) {
        imageView.image = model.image
        titleLabel.text = model.title
        textView.text = model.description
    }
}

// MARK: - Private
private extension EmployeeCustomInformationView {
    func setupUI() {
        
        enum ImageViewSize {
            static let height: CGFloat = 30
            static let width: CGFloat = 30
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: ImageViewSize.height),
            imageView.widthAnchor.constraint(equalToConstant: ImageViewSize.width),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16)
        ])
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            rightAnchor.constraint(equalTo: textView.rightAnchor, constant: 16)
        ])
    }
}
