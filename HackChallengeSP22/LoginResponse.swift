//
//  LoginResponse.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/4/22.
//

import SwiftUI

struct LoginResponse: Codable {
    var session_token: String
    var session_expiration: String
    var update_token: String
}

