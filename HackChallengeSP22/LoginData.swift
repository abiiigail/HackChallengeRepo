//
//  LoginData.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/4/22.
//

import SwiftUI

struct LoginData: Codable {
    let username: String
    let password: String
}

struct RegisterData: Codable {
    let first_name: String
    let username: String
    let password: String
}

extension LoginData {
    static let data = LoginData(username: "ac2623@cornell.edu", password: "ABC123")
}
