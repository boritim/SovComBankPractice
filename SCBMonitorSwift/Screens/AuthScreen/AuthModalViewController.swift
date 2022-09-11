//
//  AuthModalViewController.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 14.07.2022.
//

import UIKit

final class AuthModalViewController: UIViewController {
    
    weak var authScreenFlowCoordinatorHandler: AuthScreenFlowCoordinatorHandler?
    
    // MARK: - Private properties
    private var currentContainerHeight: CGFloat = 175
    private let dismissibleHeight: CGFloat = 80
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = MColors.white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = MColors.mineShaft
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "close-icon"), for: .normal)
        return closeButton
    }()
    
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.text = "Ошибка"
        errorLabel.textColor = MColors.heliotrope
        errorLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return errorLabel
    }()
    
    private lazy var wrongLoginOrPasswordLabel: UILabel = {
        let wrongLoginOrPasswordLabel = UILabel()
        wrongLoginOrPasswordLabel.text = "Неправильный логин или пароль"
        wrongLoginOrPasswordLabel.textColor = MColors.maco
        wrongLoginOrPasswordLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return wrongLoginOrPasswordLabel
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        setupUI()
        setupPanGesture()
        setupTapGesture()
    }
}

// MARK: - Private
private extension AuthModalViewController {
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAction))
        tapGesture.delaysTouchesBegan = false
        tapGesture.delaysTouchesEnded = false
        dimmedView.addGestureRecognizer(tapGesture)
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanAction))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        containerView.addGestureRecognizer(panGesture)
    }
    
    func setupUI() {
        
        let maxDimmedAlpha: CGFloat = 0.3
        
        let closeButtonHeight: CGFloat = 40
        let defaultHeight: CGFloat = 175
        
        dimmedView.alpha = maxDimmedAlpha
        
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dimmedView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: dimmedView.topAnchor),
            view.leftAnchor.constraint(equalTo: dimmedView.leftAnchor),
            view.bottomAnchor.constraint(equalTo: dimmedView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: dimmedView.rightAnchor)
        ])
        
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: defaultHeight),
            view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
        
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: closeButtonHeight),
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            containerView.rightAnchor.constraint(equalTo: closeButton.rightAnchor, constant: 16)
        ])
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: errorLabel.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 60),
        ])
        
        wrongLoginOrPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(wrongLoginOrPasswordLabel)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: wrongLoginOrPasswordLabel.centerXAnchor),
            wrongLoginOrPasswordLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20)
        ])
    }
    
    // MARK: - Objc
    @objc func closeButtonPressed(sender: UIButton) {
        authScreenFlowCoordinatorHandler?.dismissAuthModalViewController()
    }
    
    @objc func handlePanAction(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: containerView)
        let newHeight = currentContainerHeight - translation.y
        if gesture.state == .ended {
            if newHeight < dismissibleHeight {
                authScreenFlowCoordinatorHandler?.dismissAuthModalViewController()
            }
        }
    }
    
    @objc func handleTapAction(gesture: UITapGestureRecognizer) {
        authScreenFlowCoordinatorHandler?.dismissAuthModalViewController()
    }
}
