//
//  ResultsModel.swift
//  itunesTop100
//
//  Created by Craig Belinfante on 2/4/22.
//

import Foundation

struct Results: Codable {
    let results: [AlbumResult]
}

struct Feed: Codable {
    let feed: Results
}

struct AlbumResult: Identifiable, Codable {
    
    let id = UUID()
    let copyright: String?
    let artist: String?
    let album: String?
    let artwork: String?
    let releaseDate: String?
    let albumURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case copyright = "copyright"
        case artist = "artistName"
        case album = "name"
        case artwork = "artworkUrl100"
        case releaseDate = "releaseDate"
        case albumURL = "url"
    }
}
