//
//  ResultsModel.swift
//  itunesTop100
//
//  Created by Craig Belinfante on 2/4/22.
//

import Foundation

struct Results: Codable {
    let results: [AlbumResult]
    let copyright: String?
}

struct Feed: Codable {
    let feed: Results
}

struct Genre: Codable {
    let name: String
}

struct AlbumResult: Identifiable, Codable {
    
    let id = UUID()
    let artist: String?
    let album: String?
    let artwork: String?
    var genre: [Genre]?
    let releaseDate: String?
    let albumURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case artist = "artistName"
        case album = "name"
        case artwork = "artworkUrl100"
        case genre = "genres"
        case releaseDate = "releaseDate"
        case albumURL = "url"
    }
}
