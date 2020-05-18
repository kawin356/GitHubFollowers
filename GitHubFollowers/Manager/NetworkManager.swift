//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 18/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/"
    
    private init() { }
    
    func getFollower(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endPoint = baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(nil,"invalid Username, Please try again")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let _ = error else {
                completion(nil,"Please check yout Internet Connection")
                return
            }
            
            
            
        }
        
        task.resume()
        
        
    }
}
