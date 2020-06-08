//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 22/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
  
  var username: String!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
    
    NetworkManager.shared.getUserInfo(for: username) { (result) in
      switch result {
      case .success(let user):
        print(user)
      case .failure(let error):
        self.presentGFAlertOnTheMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
      }
    }
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}
