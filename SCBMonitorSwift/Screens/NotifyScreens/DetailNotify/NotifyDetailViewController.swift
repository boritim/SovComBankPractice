//
//  NotifyDetaiViewController.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 10.07.2022.
//

import UIKit

final class NotifyDetailViewController: UIViewController {
    
    // MARK: - Public Properties
    var identification = Int()
    
    // MARK: - Private Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Layout.TitleLabel.text
        label.tintColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = Layout.TextLabel.text
        label.numberOfLines = Layout.TextLabel.numberOfLines
        label.sizeToFit()
        label.textColor = Layout.TextLabel.textColor
        return label
    }()
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        //        fetchReqest()
        
        setupView()
    }
}
// MARK: - Setup UI
private extension NotifyDetailViewController {
    
    func setupView() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16)
        ])
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 16)
        ])
        
        scrollView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            scrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: contentStackView.rightAnchor)
        ])
        contentStackView.addArrangedSubview(textLabel)
    }
}

// MARK: - Layout
private extension NotifyDetailViewController {
    struct Layout {
        struct TextLabel {
            static let text = """
                                Сегодня поздравляем Татьяну. Собираем деньги на подарок.
                                Вдруг будет много текста.
                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget do
                                """
            static let numberOfLines = 0
            static let textColor = UIColor.black
        }
        struct TitleLabel {
            static let text = "День рождения Татьяны"
        }
    }
}
