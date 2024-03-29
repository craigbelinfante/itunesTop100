//
//  TableView.swift
//  itunesTop100
//
//  Created by Craig Belinfante on 2/7/22.
//

import SwiftUI

struct TableView: View {
    @ObservedObject var albumResultsVM = AlbumResultsViewModel()
    let album: AlbumResult
    
    var body: some View {
        HStack {
            imageView
            VStack(alignment: .leading, spacing: 8) {
                
                Text(album.album ?? "No Album")
                    .font(.system(size: 18))
                    .bold()
                
                Text(album.artist ?? "No Artist")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
        .onAppear(perform: {
            albumResultsVM.getImage(with: album)
        })
    }
    
    private var imageView: some View {
        albumResultsVM.image
            .resizable()
            .frame(width: 70, height: 70)
            .cornerRadius(12)
            .shadow(color: .gray, radius: 5)
    }
}

//struct TableView_Previews: PreviewProvider {
//    static var previews: some View {
//        TableView()
//    }
//}
