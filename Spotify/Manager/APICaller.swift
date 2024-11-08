//
//  APICaller.swift
//  Spotify
//
//  Created by Ümit Şimşek on 3.10.2024.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    enum APIError: Error{
        case failedToGetData
    }
    public func getNewReleases(completion: @escaping((Result<NewReleasesResponse,Error>)) -> Void){
        createRequest(with: URL(string: Constant.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    public func getFeaturedPlaylist(completion: @escaping((Result<FeaturedPlayListResponse,Error>)->Void)){
        createRequest(with: URL(string: Constant.baseAPIURL + "/browse/featured-playlists?limit=2"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                   let result = try JSONDecoder().decode(FeaturedPlayListResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    public func getRecommendations(genres: Set<String>,completion: @escaping((Result<String,Error>)-> Void)) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constant.baseAPIURL + "/recommendations?seed_genres=\(seeds)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data
                                                                , options: .allowFragments)
                    
                   //let result = try JSONDecoder().decode(FeaturedPlayListResponse.self, from: data)
                    print(json)
                    //completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func getRecommendedGenres(completion: @escaping((Result<RecomendedGenresResponse,Error>)-> Void)) {
        createRequest(with: URL(string: Constant.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
    
                    let result = try JSONDecoder().decode(RecomendedGenresResponse.self, from: data)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func getCurrentUserProfile(completion: @escaping(Result<UserProfile, Error>) -> Void){
        createRequest(with: URL(string: Constant.baseAPIURL + "/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data,  error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    private func createRequest(with url: URL?,type: HTTPMethod,completion: @escaping(URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else{
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
