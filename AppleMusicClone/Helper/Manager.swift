//
//  Manager.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/04.
//

import Foundation
import AVFoundation

//추후 FileManager를 사용할 경우 사용될 것 같습니다.

class SongManager {
    static let shared = SongManager()
    var songConfig = SongConfig()
}

//MARK: - init
struct SongConfig {
    private var audioPlayer: AVPlayer!
    private var isPlaying: Bool = false
    private var previousURL: URL?
}
    
//MARK: - function
extension SongConfig {
    mutating func toggleSong(url: URL) {
        if isDifferentSong(url: url) {
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
        previousURL = url
    }
    
    private func isDifferentSong(url: URL) -> Bool {
        return previousURL == nil || previousURL != url
    }
}
