//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 16/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
