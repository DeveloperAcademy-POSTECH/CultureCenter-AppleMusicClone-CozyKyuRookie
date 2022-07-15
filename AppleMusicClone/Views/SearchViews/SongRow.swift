//
//  SongRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import AVFoundation
import SwiftUI

struct SongRow: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @State private var audioPlayer: AVPlayer!
    @State private var isPlaying: Bool = false
    @State private var previousURL: URL?

    var body: some View {
        LazyVStack {
            ForEach(searchViewModel.songs.indices, id: \.self) { index in
                Button {
                    guard let url = searchViewModel.songs[index].songURL else { return }
                    previousURL = toggleSong(url: url, isDifferentSong: previousURL == nil || previousURL != url)
                } label: {
                    HStack {
                        AsyncImage(url: searchViewModel.songs[index].imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 5)
                        }
                        .frame(width: 50, height: 50)
                        Text(searchViewModel.songs[index].inform)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
                Divider()
            }
        }
    }
}

extension SongRow {
    private func toggleSong(url: URL, isDifferentSong: Bool) -> URL {
        if isDifferentSong {
            let item = AVPlayerItem(url: url)
            let player = AVPlayer(playerItem: item)
            audioPlayer = player
            isPlaying = false
        }
        isPlaying.toggle()
        if isPlaying {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }
        return url
    }
}
