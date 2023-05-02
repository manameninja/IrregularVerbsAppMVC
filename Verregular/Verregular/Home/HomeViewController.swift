//
//  HomeViewController.swift
//  Verregular
//
//  Created by Даниил Павленко on 23.04.2023.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Verregular".uppercased()
        label.font = .boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Select verbs".localized, for: .normal)
        button.backgroundColor = defaultColor
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(goToSelectVerbsViewController), for:
                .touchUpInside)
        
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Train verbs".localized, for: .normal)
        button.backgroundColor = defaultColor
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(goToTrainViewController), for:
                .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    let cornerRadius: CGFloat = 20
    let buttonHeight: CGFloat = 80
    let buttonWidth: CGFloat = 160
    
    let defaultColor: UIColor = .systemGray5
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    @objc
    private func goToSelectVerbsViewController() {
        navigationController?.pushViewController(SelectVerbsViewController(), animated: true)
    }
    
    @objc
    private func goToTrainViewController() {
        navigationController?.pushViewController(TrainViewController(), animated: true)
    }
    
    private func setupConstraints() {
        firstButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            .isActive = true
        firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        firstButton.heightAnchor.constraint(equalToConstant: buttonHeight)
            .isActive = true
        firstButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80)
            .isActive = true
        
        secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 40)
            .isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: buttonHeight)
            .isActive = true
        secondButton.widthAnchor.constraint(equalTo: firstButton.widthAnchor)
            .isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: firstButton.topAnchor, constant: -80)
            .isActive = true
    }
}
