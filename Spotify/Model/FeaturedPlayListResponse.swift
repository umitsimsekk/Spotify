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

struct User: Codable {
    let display_name: String
    let external_urls: [String:String]
    let id:String
}
