//
//  CalendarTableViewCell.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 18.07.2022.
//

import UIKit

protocol CalendarCellDelegate: AnyObject {
    func openDetailCalendar()
}

final class CalendarCell: UITableViewCell {
    
    weak var calendarDelegate: CalendarCellDelegate?
    
    // MARK: - Private Properties
    private var cellId = Int()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        //        label.text = "07.02.2022-13.02.2022"
        return label
    }()
    private let conteiner: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = MColors.whisper.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    private let detailTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отработанные часы за неделю : 45:00", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = MColors.selago
        button.layer.borderWidth = 1
        button.layer.borderColor = MColors.whisper.cgColor
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return button
    }()
    
    private var collectionModel = [CalCollectionModel(id: 1, day: "ПН", time: "07:00"),
                                   CalCollectionModel(id: 2, day: "ВТ", time: "09:00"),
                                   CalCollectionModel(id: 3, day: "СР", time: "08:45"),
                                   CalCollectionModel(id: 4, day: "ЧТ", time: "7:49"),
                                   CalCollectionModel(id: 5, day: "ПТ", time: "09:50"),
                                   CalCollectionModel(id: 6, day: "СБ", time: "-"),
                                   CalCollectionModel(id: 7, day: "ВС", time: "-")]
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(_ model: CalendarModel) {
        cellId = model.id
        dateLabel.text = model.date
    }
    
    // MARK: - Objc
    @objc func detailCalendarDidTap() {
        calendarDelegate?.openDetailCalendar()
    }
}

// MARK: - Setup Cell
private extension CalendarCell {
    
    func setupView () {
        contentView.addSubview(conteiner)
        conteiner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conteiner.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: conteiner.bottomAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: conteiner.rightAnchor, constant: 16)
        ])
        
        conteiner.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 20),
            dateLabel.leftAnchor.constraint(equalTo: conteiner.leftAnchor, constant: 16)
        ])
        
        conteiner.addSubview(detailTimeButton)
        detailTimeButton.translatesAutoresizingMaskIntoConstraints = false
        
        detailTimeButton.addTarget(self, action: #selector(detailCalendarDidTap), for: .touchUpInside)

        NSLayoutConstraint.activate([
            detailTimeButton.heightAnchor.constraint(equalToConstant: 60),
            
            detailTimeButton.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 132),
            detailTimeButton.leftAnchor.constraint(equalTo: conteiner.leftAnchor),
            conteiner.bottomAnchor.constraint(equalTo: detailTimeButton.bottomAnchor),
            conteiner.rightAnchor.constraint(equalTo: detailTimeButton.rightAnchor)
        ])
    }
}

// MARK: - Setup CollectionView
private extension CalendarCell {
    func setupCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: flowLayout)
        
        collectionView.dataSource = self
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 38, height: 42)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        collectionView.register(CalendarCollectionCell.self, forCellWithReuseIdentifier: calCollectionIdentifier)
        
        conteiner.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: conteiner.topAnchor, constant: 68),
            collectionView.leftAnchor.constraint(equalTo: conteiner.leftAnchor, constant: 15),
            detailTimeButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 22),
            conteiner.rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: 15)
        ])
    }
}

// MARK: - CollectionView metods
extension CalendarCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calCollectionIdentifier,
                                                      for: indexPath as IndexPath)
                                                      as! CalendarCollectionCell
        
        let collectionData = collectionModel[indexPath.item]
        cell.configure(collectionData)
        cell.backgroundColor = UIColor.green
        return cell
    }
}
