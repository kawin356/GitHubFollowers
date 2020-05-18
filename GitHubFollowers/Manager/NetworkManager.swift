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
    let baseUrl = "https://api.github.com/users/"
    
    private init() { }
    
    func getFollower(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        let endPoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(nil,"invalid Username, Please try again")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil,"Please check yout Internet Connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completion(nil, "The data received from server is invalid. Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let follower = try decoder.decode([Follower].self, from: data)
                completion(follower, nil)
            } catch {
                completion(nil, "The data received from server is invalid. Please try again.")
            }
            
        }
        
        task.resume()
        
        
    }
}
