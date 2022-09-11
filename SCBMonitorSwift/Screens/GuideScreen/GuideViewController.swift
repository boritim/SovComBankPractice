//
//  GuideViewController.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 07.07.2022.
//

import UIKit

final class GuideScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = Layout.DescriptionLabel.text
        label.tintColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Для новичков"
        
        setupView()
    }
}

// MARK: - Setup View
private extension GuideScreenViewController {
    
    func setupView() {
        view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            subTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16)
        ])
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 16)
        ])
        
        scrollView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            scrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: contentStackView.leftAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor),
            scrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: contentStackView.rightAnchor)
        ])
        
        contentStackView.addArrangedSubview(textLabel)
    }
}

// MARK: - Layout
private extension GuideScreenViewController {
    struct Layout {
        struct TextLabel {
            static let text = """
                            Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил,что он у себя в постели превратился в страшное насекомое.
                            Лежа на панцирнотвердой спине, он видел, стоило ему приподнять голову, свой коричневый, выпуклый, разделенный дугообразными чешуйками живот,
                            на верхушке которого еле держалось готовое вот-вот окончательно сползти одеяло.
                            
                            Его многочисленные, убого тонкие по сравнению с остальным телом ножки беспомощно копошились у него перед глазами. «Что со мной случилось?» – подумал он.
                            
                            Это не было сном. Его комната, настоящая, разве что слишком маленькая, но обычная комната, мирно покоилась в своих четырех хорошо знакомых стенах.
                            Над столом, где были разложены распакованные образцы сукон – Замза был коммивояжером, – висел портрет, который он недавно вырезал из иллюстрированного журнала
                            и вставил в красивую золоченую рамку.
                            На портрете была изображена дама в меховой шляпе и боа, она сидела очень прямо и протягивала зрителю тяжелую меховую муфту, в которой целиком исчезала ее рука.
                            Затем взгляд Грегора устремился в окно, и пасмурная погода – слышно было, как по жести подоконника стучат капли дождя – привела его и вовсе в грустное настроение.
                            «Хорошо бы еще немного поспать и забыть всю эту чепуху», – подумал он, но это было совершенно неосуществимо, он привык спать на правом боку, а в теперешнем своем
                            Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое.
                            Лежа на панцирнотвердой спине, он видел, стоило ему приподнять голову, свой коричневый, выпуклый, разделенный дугообразными чешуйками живот,
                            на верхушке которого еле держалось готовое вот-вот окончательно сползти одеяло.
                            Его многочисленные, убого тонкие по сравнению с остальным телом ножки беспомощно копошились у него перед глазами. «Что со мной случилось?» – подумал он.
                            Это не было сном. Его комната, настоящая, разве что слишком маленькая, но обычная комната, мирно покоилась в своих четырех хорошо знакомых стенах.
                            Над столом, где были разложены распакованные образцы сукон – Замза был коммивояжером, – висел портрет, который он недавно вырезал из иллюстрированно
                            и вставил в красивую золоченую рамку.
                            На портрете была изображена дама в меховой шляпе и боа, она сидела очень прямо и протягивала зрителю тяжелую меховую муфту, в которой целиком
                            Затем взгляд Грегора устремился в окно, и пасмурная погода – слышно было, как по жести подоконника стучат капли дождя – привела его и вовс
                            «Хорошо бы еще немного поспать и забыть всю эту чепуху», – подумал он, но это было совершенно неосуществимо, он привык спать на правом
                            """
            static let numberOfLines = 0
            static let textColor = UIColor.black
        }
        struct DescriptionLabel {
            static let text = "Правила поведения в офисе"
        }
    }
}
