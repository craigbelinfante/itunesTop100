//
//  AlbumListView.swift
//  itunesTop100
//
//  Created by Craig Belinfante on 2/6/22.
//

import SwiftUI

struct AlbumListView: View {
    @ObservedObject private var viewModel = AlbumResultsViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.albums) { album in
                    TableView(album: album)
                }
            }.navigationBarTitle("Top Albums")
        }.onAppear(perform: {
            viewModel.getAlbums()
        })
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
