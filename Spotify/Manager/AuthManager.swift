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
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes : TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping((Bool)->Void)){
        //Get token
        print("runned")
        guard let url = URL(string: Constant.tokenAPIURL) else {
            print("url error")
            return
        }
        print("runned")

        var components = URLComponents()
        components.queryItems = [
                URLQueryItem(name: "grant_type",
                             value: "authorization_code"),
                URLQueryItem(name: "code",
                             value: code),
                URLQueryItem(name: "redirect_uri",
                             value: "https://www.google.com")
        ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)

        
        let basicToken = Constant.clientID+":"+Constant.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        
       
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            guard let data = data, error == nil else{
                print("data error")
                completion(false)
                return
            }
            do{
                let result = try JSONDecoder().decode(AuthResponse.self,from:data)
                self?.cacheToken(result: result)
                print("success")
                completion(true)
            }
            catch {
                print("error:\(error.localizedDescription)")
                completion(false)
                
            }
        }
        task.resume()
        
    }
    public func refreshAccessToken(){
        
    }
    private func cacheToken(result: AuthResponse){
        UserDefaults.setValue(result.access_token, forKey: "access_token")
        UserDefaults.setValue(result.refresh_token, forKey: "refresh_token")
        UserDefaults.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)),
                              forKey: "expirationDate")

    }
}
