//
//  PersonalPagePopUpViewController.swift
//  SCBMonitorSwift
//
//  Created by Тимофей Борисов on 14.07.2022.
//

import UIKit

protocol PersonalPopUpDelegate: AnyObject {
    func saveData(_ data: String)
}

class PersonalPagePopupViewController: UIViewController {
    
    weak var delegatePopUp: PersonalPopUpDelegate?
    
    // MARK: - Private Properties
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    private var saveButton: DefaultButton = {
        let button = DefaultButton()
        button.setTitle("СОХРАНИТЬ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    private var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close-icon"), for: .normal)
        return button
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Навыки"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private var textView: UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isSelectable = true
        textView.isEditable = true
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = MColors.whisper.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        return textView
    }()
    
    private let defaultHeight: CGFloat = 229
    
    private let dismissibleHeight: CGFloat = 200
    
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64

    private var currentContainerHeight: CGFloat = 229
    
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateShowShadowView()
        animatePresentContainer()
        setupPanGesture()
        setupTapGesture()
    }
    
    // MARK: - Setup view
    func setupView() {
        //View setup
        view.addSubview(shadowView)
        view.addSubview(containerView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: view.topAnchor),
            shadowView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            view.rightAnchor.constraint(equalTo: shadowView.rightAnchor),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16)
        ])
        
        //Buttons setup
        containerView.addSubview(saveButton)
        containerView.addSubview(exitButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        exitButton.addTarget(self, action: #selector(animateDismissViewDidTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 40),
            containerView.rightAnchor.constraint(equalTo: saveButton.rightAnchor, constant: 20),
            
            exitButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
            containerView.rightAnchor.constraint(equalTo: exitButton.rightAnchor, constant: 21)
        ])
        
        containerView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.addTarget(self, action: #selector(saveDataDidTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 57),
            textView.leftAnchor.constraint(equalTo: saveButton.leftAnchor),
            saveButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            saveButton.rightAnchor.constraint(equalTo: textView.rightAnchor)
        ])
    }
    
    // MARK: - Objc
    @objc func animateDismissViewDidTap() {
        animateDismissView()
    }
    
    @objc func saveDataDidTap() {
        let textData = textView.text ?? "Default Value"
        delegatePopUp?.saveData(textData)
        animateDismissView()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 20
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        let isDraggingDown = translation.y > 0

        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            } else
            if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            } else
            if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            } else
            if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    @objc func handleTapAction(gesture: UITapGestureRecognizer) {
        animateDismissView()
    }
}
// MARK: - Private
private extension PersonalPagePopupViewController {
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowShadowView() {
        shadowView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.shadowView.alpha = 0.6
        }
    }
    
    func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
        
        shadowView.alpha = 0.6
        UIView.animate(withDuration: 0.4) {
            self.shadowView.alpha = 0
        }
    completion: { _ in
        self.dismiss(animated: false)
        }
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(gesture:)))
        tapGesture.delaysTouchesBegan = false
        tapGesture.delaysTouchesEnded = false
        shadowView.addGestureRecognizer(tapGesture)
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    func saveButtonActive() {
        if textView.hasText {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .red
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .black
        }
    }
}
