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
  let itemViewOne = UIView()
  let itemViewTwo = UIView()
  var itemViews: [UIView] = []
  
  var username: String!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureVC()
    getUserInfo()
    layoutUI()
  }
  
  
  func configureVC() {
    view.backgroundColor = .systemBackground
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  
  func getUserInfo() {
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
  }
  
  
  func layoutUI() {
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    
    itemViews = [headerView, itemViewOne, itemViewTwo]
    
    for itemView in itemViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
      ])
    }
    
    itemViewOne.backgroundColor = .systemPink
    itemViewTwo.backgroundColor = .systemBlue
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180),
      
      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
      
      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
      
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
