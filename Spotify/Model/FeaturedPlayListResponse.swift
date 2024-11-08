//
//  FeaturedPlayListResponse.swift
//  Spotify
//
//  Created by Ümit Şimşek on 8.11.2024.
//

import Foundation


struct FeaturedPlayListResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable{
    let items: [Playlist]
}
struct Playlist : Codable {
    let description: String
    let external_urls: [String:String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
struct User: Codable {
    let display_name: String
    let external_urls: [String:String]
    let id:String
}
