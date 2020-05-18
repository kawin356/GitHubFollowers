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
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()

        getFollowers()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollower(for: username, page: 1) { result in
            
            switch result {
                
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnTheMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
