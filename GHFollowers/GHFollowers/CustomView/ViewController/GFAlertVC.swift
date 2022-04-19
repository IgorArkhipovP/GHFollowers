//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 13.03.2022.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel (textAlignment: .center)
    let actionButton = GFButton(color: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var bodyMessage: String?
    var buttonTitle: String?
    
    let paddling: CGFloat = 5
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.bodyMessage = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: paddling),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddling),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddling),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureActionButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -paddling),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddling),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddling),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = bodyMessage ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: paddling),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddling),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddling),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}
