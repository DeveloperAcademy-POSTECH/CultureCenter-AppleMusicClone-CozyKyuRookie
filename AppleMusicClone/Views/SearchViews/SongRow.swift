//
//  SongRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import SwiftUI
import AVFoundation

struct SongRow: View {
    
    @ObservedObject var searchViewModel: SearchViewModel
    @State private var audioPlayer: AVPlayecr
    @State private var isPlaying: Bool = false
    @State private var previousURL: URL?
    
    var body: some View {
        
        LazyVStack {
            ForEach(searchViewModel.songs.indices, id: \.self) { index in
                Button {
                    guard let url = searchViewModel.songs[index].songUrl else { return }
                    previousURL = toggleSong(url: url, isDifferentSong: previousURL == nil || previousURL != url)
                } label: {
                    HStack {
                        AsyncImage(url:searchViewModel.songs[index].imageUrl) { image in
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
            self.audioPlayer = player
            self.isPlaying = false
        }
        self.isPlaying.toggle()
        if self.isPlaying {
            self.audioPlayer.play()
        } else {
            self.audioPlayer.pause()
        }
        return url
    }
}
