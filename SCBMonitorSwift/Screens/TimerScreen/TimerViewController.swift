//
//  TimerViewController.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 14.07.2022.
//

import UIKit


enum Animation {
    static var isStarted = false
    static var isOnGoing = false
    static var isFinished = false
}

struct LinePosition {
    
    let moveX: CGFloat
    let moveY: CGFloat
    let addLineX: CGFloat
    let addLineY: CGFloat
}

final class TimerViewController: UIViewController {
    
    weak var timerScreenFlowCoordinatorHandler: TimerScreemFlowCoordinatorHandler?
    
    // MARK: - Private properties
    private let keyForInternalCircleViewAnimation = "keyForInternalCircleViewAnimation"
    
    private var linePositions: [LinePosition] = []
    
    private let internalShapeAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    private let internalShape = CAShapeLayer()
    private let externalShape = CAShapeLayer()
    
    private let lineShape = CAShapeLayer()
    
    private lazy var startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("СТАРТ", for: .normal)
        startButton.setImage(UIImage(named: "play-icon"), for: .normal)
        startButton.backgroundColor = MColors.dodgerBlue
        startButton.tintColor = MColors.white
        return startButton
    }()
    
    private lazy var pinImageView: UIImageView = {
        let pinImageView = UIImageView()
        pinImageView.image = UIImage(named: "pin")
        return pinImageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "18.07.2022"
        dateLabel.textColor = MColors.maco
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return dateLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "00:00:00"
        timeLabel.textColor = MColors.mineShaft
        timeLabel.font = UIFont.systemFont(ofSize: 33, weight: .bold)
        return timeLabel
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Таймер"
        view.backgroundColor = .systemBackground
        
        obtainLinePositions()
        
        setupUI()
        setupCircleViews()
        setupLines()
    }
}

// MARK: - Private
private extension TimerViewController {
    func setupUI() {
        
        let startButtonHeight: CGFloat = 50
        let startButtonWidth: CGFloat = 180
        
        startButton.layer.cornerRadius = 25
        startButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        startButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: startButtonHeight),
            startButton.widthAnchor.constraint(equalToConstant: startButtonWidth),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 190),
            view.centerXAnchor.constraint(equalTo: startButton.centerXAnchor)
        ])
        
        pinImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinImageView)
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: pinImageView.centerYAnchor, constant: 185),
            view.centerXAnchor.constraint(equalTo: pinImageView.centerXAnchor)
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor, constant: 30),
            view.centerXAnchor.constraint(equalTo: dateLabel.centerXAnchor)
        ])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor)
        ])

    }
    
    func setupCircleViews() {
        
        let externalShapeCirclePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY - 10), radius: 110, startAngle: -(.pi / 2), endAngle: .pi * 2, clockwise: true)
        
        externalShape.path = externalShapeCirclePath.cgPath
        externalShape.lineWidth = 30
        externalShape.strokeColor = MColors.selago.cgColor
        externalShape.fillColor = MColors.transparentWhite
        view.layer.addSublayer(externalShape)
        
        let internalShapeCirclePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY - 10), radius: 95, startAngle: -(.pi / 2), endAngle: .pi * 2, clockwise: true)
        
        internalShape.path = internalShapeCirclePath.cgPath
        internalShape.lineWidth = 10
        internalShape.strokeColor = MColors.heliotrope.cgColor
        internalShape.fillColor = MColors.transparentWhite
        internalShape.strokeEnd = 0
        internalShape.lineCap = .round
        view.layer.addSublayer(internalShape)
    }
    
    func configureButton() {
        let image = (Animation.isOnGoing) ? UIImage(named: "pause-icon") : UIImage(named: "play-icon")
        let backgroundColor = (Animation.isOnGoing) ? MColors.spray : MColors.dodgerBlue
        let title = (Animation.isOnGoing) ? "СТОП" : "СТАРТ"
        startButton.setImage(image, for: .normal)
        startButton.backgroundColor = backgroundColor
        startButton.setTitle(title, for: .normal)
    }
    
    func startInternalCircleViewAnimation() {
        
        internalShapeAnimation.toValue = 1
        internalShapeAnimation.duration = 10
        internalShapeAnimation.delegate = self
        
        internalShape.add(internalShapeAnimation, forKey: keyForInternalCircleViewAnimation)
    }
    
    func setupLines() {
        for linePosition in linePositions {
            let lineShape = CAShapeLayer()
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: linePosition.moveX, y: linePosition.moveY))
            linePath.addLine(to: CGPoint(x: linePosition.addLineX, y: linePosition.addLineY))
            lineShape.path = linePath.cgPath
            lineShape.strokeColor = MColors.selago.cgColor
            lineShape.fillColor = MColors.selago.cgColor
            lineShape.lineWidth = 2
            view.layer.addSublayer(lineShape)
        }
    }
    
    func obtainLinePositions() {
        linePositions = [
            (LinePosition(moveX: view.frame.midX,
                          moveY: view.frame.midY - 160,
                          addLineX: view.frame.midX,
                          addLineY: view.frame.midY - 143)),
            (LinePosition(moveX: view.frame.midX,
                          moveY: view.frame.midY + 125,
                          addLineX: view.frame.midX,
                          addLineY: view.frame.midY + 142)),
            (LinePosition(moveX: view.frame.midX + 150,
                          moveY: view.frame.midY - 10,
                          addLineX: view.frame.midX + 133,
                          addLineY: view.frame.midY - 10)),
            (LinePosition(moveX: view.frame.midX - 150,
                          moveY: view.frame.midY - 10,
                          addLineX: view.frame.midX - 133,
                          addLineY: view.frame.midY - 10)),
            (LinePosition(moveX: view.frame.midX - 130,
                          moveY: view.frame.midY - 85,
                          addLineX: view.frame.midX - 113,
                          addLineY: view.frame.midY - 75)),
            (LinePosition(moveX: view.frame.midX + 130,
                          moveY: view.frame.midY - 85,
                          addLineX: view.frame.midX + 113,
                          addLineY: view.frame.midY - 75)),
            (LinePosition(moveX: view.frame.midX + 130,
                          moveY: view.frame.midY + 65,
                          addLineX: view.frame.midX + 113,
                          addLineY: view.frame.midY + 55)),
            (LinePosition(moveX: view.frame.midX - 130,
                          moveY: view.frame.midY + 65,
                          addLineX: view.frame.midX - 113,
                          addLineY: view.frame.midY + 55)),
            (LinePosition(moveX: view.frame.midX - 80,
                          moveY: view.frame.midY - 140,
                          addLineX: view.frame.midX - 67,
                          addLineY: view.frame.midY - 123)),
            (LinePosition(moveX: view.frame.midX + 80,
                          moveY: view.frame.midY - 140,
                          addLineX: view.frame.midX + 67,
                          addLineY: view.frame.midY - 123)),
            (LinePosition(moveX: view.frame.midX + 80,
                          moveY: view.frame.midY + 120,
                          addLineX: view.frame.midX + 67,
                          addLineY: view.frame.midY + 107)),
            (LinePosition(moveX: view.frame.midX - 80,
                          moveY: view.frame.midY + 120,
                          addLineX: view.frame.midX - 67,
                          addLineY: view.frame.midY + 107)),
        ]
    }
    
    // MARK: - Objc
    @objc func startButtonPressed(sender: UIButton) {
        
        switch Animation.isStarted {
        case true:
            switch Animation.isOnGoing {
            case true:
                internalShape.pauseAnimation()
            case false:
                internalShape.resumeAnimation()
            }
            Animation.isOnGoing.toggle()
        case false:
            startInternalCircleViewAnimation()
            Animation.isFinished.toggle()
            Animation.isStarted.toggle()
            Animation.isOnGoing.toggle()
        }
        configureButton()
    }
}

// MARK: - CAAnimationDelegate
extension TimerViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        Animation.isFinished.toggle()
        Animation.isStarted.toggle()
        Animation.isOnGoing.toggle()
        configureButton()
    }
}
