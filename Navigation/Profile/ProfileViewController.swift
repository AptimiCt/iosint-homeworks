//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Востриков on 28.11.2021.
//

import UIKit

class ProfileViewController: UIViewController, SetupViewProtocol {

    init(){
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = tabBarItemLocal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tabBarItemLocal = UITabBarItem(title: "Profile",
                                       image: UIImage(systemName: "person.crop.circle.fill"),
                                       tag: 1)
    let profileHeaderView = ProfileHeaderView()
    let newButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        newButton.setTitle("newButton", for: .normal)
        newButton.backgroundColor = .cyan
        view.backgroundColor = .lightGray
        self.navigationItem.title = "Profile"
        view.addSubview(profileHeaderView)
        view.addSubview(newButton)
        profileHeaderView.setStatusButton.addTarget(self,
                                                    action: #selector(buttonPressed),
                                                    for: .touchUpInside)
        configureConstraints()
    }
    
    func configureConstraints(){
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        newButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    @objc func buttonPressed(){
        guard let text = profileHeaderView.statusLabel.text else { return }
        print(text)
    }
}
