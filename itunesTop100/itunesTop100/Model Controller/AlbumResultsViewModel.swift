//
//  AlbumResultsViewModel.swift
//  itunesTop100
//
//  Created by Craig Belinfante on 2/6/22.
//

import SwiftUI

final class AlbumResultsViewModel: ObservableObject {
    @Published var albums: [AlbumResult] = []
    @Published var image = Image(systemName: "music.note.list")
    
    func getAlbums() {
        ResultsController.shared.fetchResults(completion: { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    self.albums = albums
                case .failure(let error):
                    print("Failed to fetch results \(error)")
                }
            }
        })
    }
    
    func getImage(with viewModel: AlbumResult) {
        guard let imageURL = viewModel.artwork else {return}
        ResultsController.shared.fetchImage(urlString: imageURL) { [weak self] (result) in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    guard let inputImage = UIImage(data: imageData) else { return }
                    self?.image = Image(uiImage: inputImage)
                }
            case .failure(let error):
                print("Failed to fetch image \(error)")
            }
        }
    }
}
