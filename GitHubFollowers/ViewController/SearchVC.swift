//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 16/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
  
  let logoImageView = UIImageView()
  let usernameTextField = GFTextField()
  let callActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
  
  var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureLogoImage()
    configureUsernameTextField()
    configureCallToActionButton()
    createDismissKeyboardGesture()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  
  private func createDismissKeyboardGesture() {
    let tab = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tab)
  }
  
  
  @objc func pushFollowerListVC() {
    guard isUsernameEntered else {
      presentGFAlertOnTheMainThread(
        title: "Empty username",
        message: "Please enter a username, We need to know who to looking for 😊.",
        buttonTitle: "Ok")
      return
    }
    
    let followerListVC = FollowerListVC()
    followerListVC.username = usernameTextField.text
    followerListVC.title = usernameTextField.text
    
    navigationController?.pushViewController(followerListVC, animated: true)
  }
  
  
  private func configureLogoImage() {
    view.addSubview(logoImageView)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = UIImage(named: "gh-logo")
    
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  
  private func configureUsernameTextField() {
    view.addSubview(usernameTextField)
    usernameTextField.delegate = self
    
    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  
  private func configureCallToActionButton() {
    view.addSubview(callActionButton)
    callActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      callActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}


extension SearchVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pushFollowerListVC()
    
    return true
  }
}
