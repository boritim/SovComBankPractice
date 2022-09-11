//
//  AuthViewController.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 13.07.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    weak var authScreenFlowCoordinatorHandler: AuthScreenFlowCoordinatorHandler?
    
    // MARK: - Private properties
    private var isHidePasswordButtonPressed = false
    
    private lazy var topImageView: UIImageView = {
        let topImageView = UIImageView()
        topImageView.image = UIImage(named: "picture")
        return topImageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Добро пожаловать \n \t в SCB Monitor!"
        welcomeLabel.textColor = MColors.mineShaft
        welcomeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return welcomeLabel
    }()
    
    private lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.attributedPlaceholder = NSAttributedString(
            string: "Логин",
            attributes: [NSAttributedString.Key.foregroundColor: MColors.osloGray]
        )
        return loginTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [NSAttributedString.Key.foregroundColor: MColors.osloGray]
        )
        return passwordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = MColors.spray
        loginButton.tintColor = MColors.white
        return loginButton
    }()
    
    private lazy var hidePasswordButton: UIButton = {
        let hidePasswordButton = UIButton(type: .custom)
        hidePasswordButton.setImage(UIImage(named: "hidePassword-icon"), for: .normal)
        hidePasswordButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        return hidePasswordButton
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
}

// MARK: - Private
private extension AuthViewController {
    func setupUI() {
        
        let textFieldHeight: CGFloat = 40
        let logginButtonHeight: CGFloat = 50
        
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topImageView)
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.rightAnchor.constraint(equalTo: topImageView.rightAnchor)
        ])
        
        welcomeLabel.numberOfLines = 2
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        loginTextField.borderStyle = .roundedRect
        loginTextField.clipsToBounds = true
        loginTextField.layer.borderWidth = 1.0
        loginTextField.layer.borderColor = MColors.selago.cgColor
        loginTextField.layer.cornerRadius = 15
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginTextField)
        NSLayoutConstraint.activate([
            loginTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            loginTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            loginTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: loginTextField.rightAnchor, constant: 16)
        ])
        
        passwordTextField.rightViewMode = .always
        passwordTextField.rightView = hidePasswordButton
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = MColors.selago.cgColor
        passwordTextField.layer.cornerRadius = 15
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: 16)
        ])
        
        loginButton.layer.cornerRadius = 25
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: logginButtonHeight),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: loginButton.rightAnchor, constant: 16)
        ])
        
        hidePasswordButton.addTarget(self, action: #selector(hidePasswordButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Objc
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    
    @objc func hidePasswordButtonPressed(sender: UIButton) {
        passwordTextField.isSecureTextEntry = isHidePasswordButtonPressed ? false : true
        let image = isHidePasswordButtonPressed ? UIImage(named: "hidePassword-icon") : UIImage(named: "showPassword-icon")
        hidePasswordButton.setImage(image, for: .normal)
        isHidePasswordButtonPressed.toggle()
    }
    
    @objc func loginButtonPressed(sender: UIButton) {
        authScreenFlowCoordinatorHandler?.presentAuthModalViewController()
    }
}
