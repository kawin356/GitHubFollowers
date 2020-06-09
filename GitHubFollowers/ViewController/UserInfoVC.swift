//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 22/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
  
  let headerView = UIView()
  
  var username: String!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
    
    NetworkManager.shared.getUserInfo(for: username) { (result) in
      switch result {
      case .success(let user):
        DispatchQueue.main.async {
          self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        }
      
      case .failure(let error):
        self.presentGFAlertOnTheMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
      }
    }
    
    layoutUI()
  }
  
  func layoutUI() {
    view.addSubview(headerView)
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180)
    ])
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  func add(childVC: UIViewController, to contrainerView: UIView){
    addChild(childVC)
    contrainerView.addSubview(childVC.view)
    childVC.view.frame = contrainerView.bounds
    childVC.didMove(toParent: self)
  }
}
