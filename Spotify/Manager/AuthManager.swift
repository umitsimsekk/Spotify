//
//  AuthManager.swift
//  Spotify
//
//  Created by Ümit Şimşek on 3.10.2024.
//

import Foundation


final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var isSigned :Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var shouldRefreshToken: String? {
        return nil
    }
}
