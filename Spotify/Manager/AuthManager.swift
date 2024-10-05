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
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.google.com"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constant.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
        
    }
    
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
    
    public func exchangeCodeForToken(code: String, completion: @escaping((Bool)->Void)){
        //Get token
        
    }
    public func refreshAccessToken(){
        
    }
    private func cacheToken(){
        
    }
}
