//
//  Playlist.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

// MARK: - Playlist
struct PlaylistResponse: Codable {
    let results: PlaylistResult
}

extension PlaylistResponse {
    static func placeholder() -> PlaylistResponse {
        PlaylistResponse(results: PlaylistResult(suggestions: [PlaylistSuggestion(content: PlaylistContent(attributes: PlaylistAttribute(artwork: PlaylistArtwork(url: ""), name: "asdads")))]))
    }
}

// MARK: - Results
struct PlaylistResult: Codable {
    let suggestions: [PlaylistSuggestion]
}

// MARK: - Suggestion
struct PlaylistSuggestion: Codable {
    let content: PlaylistContent
}

// MARK: - Content
struct PlaylistContent: Codable {
    let attributes: PlaylistAttribute
}

// MARK: - Attributes
struct PlaylistAttribute: Codable {
    let artwork: PlaylistArtwork
    let name: String
}

// MARK: - Artwork
struct PlaylistArtwork: Codable {
    let url:String
}

