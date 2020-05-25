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
    
    enum Endpoint {
        static let baseURL = "https://api.github.com/users/"
        
        case getUserInfo(String)
        case getFollower(String, Int)
        
        var stringValue: String {
            switch self {
            case .getUserInfo(let username): return Endpoint.baseURL + "\(username)"
            case .getFollower(let username, let page): return Endpoint.baseURL + "\(username)/followers?per_page=100&page=\(page)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
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
        let url = Endpoint.getUserInfo(username).url
        
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
        let url = Endpoint.getFollower(username, page).url
        
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
