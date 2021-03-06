//
//  LogInViewController.swift
//  Navigation
//
//  Created by Александр Востриков on 16.01.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        return imageView
    }()
    
    let loginTextView: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Email or iPhone"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextView: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        return stackView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.textColor = .white
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    let tabBarItemLocal = UITabBarItem(title: "Profile",
                                       image: UIImage(systemName: "person.crop.circle.fill"),
                                       tag: 1)
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = tabBarItemLocal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupView()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupView(){
        scrollView.toAutoLayout()
        contentView.toAutoLayout()
        logoImageView.toAutoLayout()
        stackView.toAutoLayout()
        loginButton.toAutoLayout()
        passwordTextView.toAutoLayout()
        
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        scrollView.keyboardDismissMode = .interactive
        
        stackView.addArrangedSubview(loginTextView)
        stackView.addArrangedSubview(passwordTextView)
        contentView.addSubviews(logoImageView, stackView, loginButton)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func setupConstrains(){
        let constrains = [
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                                               constant: Constants.topMarginForLogoImageView),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.heightForLogoImageView),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.widthForLogoImageView),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: Constants.leadingMarginForStackView),
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,
                                           constant: Constants.topMarginForStackView),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: Constants.trailingMarginForStackView),
            stackView.heightAnchor.constraint(equalToConstant: Constants.heightForStackView),
            
            loginTextView.heightAnchor.constraint(equalToConstant: Constants.heightForStackView / 2),
            passwordTextView.heightAnchor.constraint(equalToConstant: Constants.heightForStackView / 2),
            
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                             constant: Constants.topMarginForLoginButton),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: Constants.heightForLoginButton),
            loginButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
            
        ]
        
        NSLayoutConstraint.activate(constrains)
    }
    
    @objc func loginButtonTapped(){
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        scrollView.contentInset.bottom = keyboardSize.height
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}
