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
    
    private func taskforGetData<ResponseType: Codable>(url: URL, responseType: ResponseType.Type, completion: @escaping (Result<ResponseType, GFError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print(String(data: data, encoding: .utf8)!)
                let object = try decoder.decode(ResponseType.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
        let endPoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.unableToComplete))
            return
        }
        
        taskforGetData(url: url, responseType: User.self) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFollower(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.unableToComplete))
            return
        }
        
        taskforGetData(url: url, responseType: [Follower].self) { result in
            switch result {
            case .success(let follower):
                completion(.success(follower))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
