//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 17/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
  
  let contrainerView = UIView()
  let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
  let messageLabel = GFBodyLabel(textAlignment: .center)
  let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
  
  var alertTitle: String?
  var message: String?
  var buttonTitle: String?
  
  let padding: CGFloat = 20
  
  init(alertTitle: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = alertTitle
    self.message = message
    self.buttonTitle = buttonTitle
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    configureContrainer()
    configureTitleLabel()
    configureActionButton()
    configureMessageLabel()
  }
  
  func configureContrainer() {
    view.addSubview(contrainerView)
    contrainerView.backgroundColor = .systemBackground
    contrainerView.layer.cornerRadius = 16
    contrainerView.layer.borderWidth = 2
    contrainerView.layer.borderColor = UIColor.white.cgColor
    contrainerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contrainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      contrainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      contrainerView.widthAnchor.constraint(equalToConstant: 280),
      contrainerView.heightAnchor.constraint(equalToConstant: 220)
    ])
  }
  
  func configureTitleLabel() {
    contrainerView.addSubview(titleLabel)
    titleLabel.text = alertTitle ?? "Something went wrong"
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contrainerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: contrainerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: contrainerView.trailingAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
  }
  
  func configureActionButton() {
    contrainerView.addSubview(actionButton)
    actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
    actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      actionButton.bottomAnchor.constraint(equalTo: contrainerView.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: contrainerView.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: contrainerView.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  func configureMessageLabel() {
    contrainerView.addSubview(messageLabel)
    messageLabel.text = message ?? "Unable to complete"
    messageLabel.numberOfLines = 4
    
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: contrainerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: contrainerView.trailingAnchor, constant: -padding),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
    ])
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}

