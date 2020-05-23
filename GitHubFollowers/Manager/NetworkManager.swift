//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 18/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    func taskforGetData<ResponseType: Decodable>(url: URL,responseType: ResponseType.Type, completion: @escaping ([ResponseType]?, GFError?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let object = try decoder.decode([ResponseType].self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, .invalidData)
            }
            
        }
        
        task.resume()
    }
    
    
    func getUserInfo(for username: String, completion: @escaping (Result<[User], GFError>) -> Void) {
        let endPoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.unableToComplete))
            return
        }
        
        taskforGetData(url: url, responseType: User.self) { (username, error) in
            guard let username = username else {
                completion(.failure(error!))
                return
            }
            completion(.success(username))
        }
    }
    
    func getFollower(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.unableToComplete))
            return
        }
        
        taskforGetData(url: url, responseType: Follower.self) { (followers, error) in
            guard let followers = followers else {
                completion(.failure(error!))
                return
            }
            completion(.success(followers))
        }
    }
}
