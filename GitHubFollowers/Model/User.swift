//
//  User.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 17/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation


struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepo: Int
    var pubilcGists: Int
    var htmlUrl: String
    var followers: Int
    var following: Int
    var createdAt: String
}
