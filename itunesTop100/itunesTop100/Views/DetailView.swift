//
//  DetailView.swift
//  itunesTop100
//
//  Created by Craig Belinfante on 2/6/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var albumResultsVM = AlbumResultsViewModel()
    let album: AlbumResult
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                imageView
                    .padding(.top, 20)
                Group {
                    Text(album.album ?? "No Album")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(album.artist ?? "No Artist")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                    
                    Text(album.releaseDate ?? "No Release Date")
                        .font(.body)
                        .fontWeight(.regular)
                    
                    Text("No Copyright")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                .padding(10)
                .onAppear(perform: {
                    albumResultsVM.getImage(with: album)
                })
                Spacer()
                
                Button("Listen on Apple Music") {
                    guard let urlString = album.albumURL else {return}
                    openURL(URL(string: urlString)!)
                }
                .buttonStyle(MusicStoreLinkButtonStyle(color: .red))
            }
        }
    }
    
    private var imageView: some View {
        ZStack {
            albumResultsVM.image
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(10)
        }
    }
}

struct MusicStoreLinkButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 85)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}

