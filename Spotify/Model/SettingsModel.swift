//
//  SettingsModel.swift
//  Spotify
//
//  Created by Ümit Şimşek on 16.10.2024.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}
    
struct Option {
    let title: String
    let handler: () -> Void
}
