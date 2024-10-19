//
//  Artist.swift
//  Spotify
//
//  Created by Ümit Şimşek on 3.10.2024.
//

import Foundation

struct Artist: Codable{
    let id: String
    let type: String
    let name: String
    let external_urls: [String: String]
}
