//
//  User.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 14.03.2022.
//

import UIKit

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var htmlUrl: String
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var createdAt: String
}
