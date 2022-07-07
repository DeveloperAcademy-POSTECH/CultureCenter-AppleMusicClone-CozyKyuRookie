//
//  Playlist.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

extension Playlist {
    static func placeholder() -> Playlist {
        Playlist(results: PlaylistResult(suggestions: [PlaylistSuggestion(kind: "", content: PlaylistContent(id: "", type: "", href: "", attributes: PlaylistAttribute(playParams: PlayParams(id: "", kind: "", versionHash: ""), url: "", isChart: false, curatorName: "", artwork: PlaylistArtwork(width: 3, height: 3, url: "", bgColor: "", textColor1: "", textColor2: "", textColor3: "", textColor4: ""), playlistType: "", name: "playlist은 없다", lastModifiedDate: "Date()",description: nil)))]))
    }
}

// MARK: - Welcome
struct Playlist: Codable {
    let results: PlaylistResult
}

// MARK: - Results
struct PlaylistResult: Codable {
    let suggestions: [PlaylistSuggestion]
}

// MARK: - Suggestion
struct PlaylistSuggestion: Codable {
    let kind: String
    let content: PlaylistContent
}

// MARK: - Content
struct PlaylistContent: Codable {
    let id, type, href: String
    let attributes: PlaylistAttribute
}

// MARK: - Attributes
struct PlaylistAttribute: Codable {
    let playParams: PlayParams
    let url: String
    let isChart: Bool
    let curatorName: String
    let artwork: PlaylistArtwork
    let playlistType, name: String
    let lastModifiedDate: String// quick type 상으로는 Date 인데 실제로 string이므로 출력안되었었다.
    let description: PlaylistDescription?
}

// MARK: - Artwork
struct PlaylistArtwork: Codable {
    let width, height: Int
    let url, bgColor, textColor1, textColor2: String
    let textColor3, textColor4: String
}

// MARK: - PlayParams
struct PlayParams: Codable {
    let id, kind, versionHash: String
}

struct PlaylistDescription: Codable {
    let standard, short: String
}
