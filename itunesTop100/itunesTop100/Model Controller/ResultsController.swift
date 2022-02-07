//
//  ResultsController.swift
//  itunesTop100
//
//  Created by Craig Belinfante on 2/6/22.
//

import Foundation

final class ResultsController: NSObject {
    
    static let shared = ResultsController()
    private override init() {}
    
    let imageCache = NSCache<NSString, NSData>()
    let baseURL = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json"
    
    func fetchResults(completion: @escaping (Result<[AlbumResult], Error>) -> Void) {
        guard let baseURL = URL(string: baseURL) else {return}
        
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(Feed.self, from: data)
                    completion(.success(results.feed.results))
                } catch {
                    completion(.failure(error))
                    print("Error fetching json results")
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                    print("Error loading albums")
                }
            }
        }.resume()
    }
    
    func fetchImage(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(.success(cachedImage as Data))
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
                if let data = data {
                    self?.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                    completion(.success(data))
                } else {
                    if let error = error {
                        completion(.failure(error))
                        print("Error fetching image")
                    }
                }
            }.resume()
        }
    }
}
