//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Kittikawin Sontinarakul on 18/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "invalid Username, Please try again"
    case unableToComplete = "Please check yout Internet Connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from server is invalid. Please try again."
}
