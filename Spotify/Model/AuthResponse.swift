//
//  AuthResponse.swift
//  Spotify
//
//  Created by Ümit Şimşek on 9.10.2024.
//

import Foundation


struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String
    let scope: String
    let token_type: String
}
