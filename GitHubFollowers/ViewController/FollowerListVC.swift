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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeCollumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    
    func createThreeCollumnFlowLayout() -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 12
        let mininumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (mininumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        
        return flowLayout
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
