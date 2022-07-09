//
//  Song.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

// MARK: - Song
struct SongResponse: Codable {
    let results: SongResult
}

extension SongResponse {
    static func placeholder() -> SongResponse {
        return SongResponse(results: SongResult(suggestions: [SongSuggestion(content: SongContent(attributes: SongAttributes(artwork: SongArtWork(url: ""), name: "")))]))
    }
}

// MARK: - Results
struct SongResult: Codable {
    let suggestions: [SongSuggestion]
}

// MARK: - Suggestion
struct SongSuggestion: Codable {
    let content: SongContent
}

// MARK: - Content
struct SongContent: Codable {
    let attributes: SongAttributes
}

// MARK: - Attributes
struct SongAttributes: Codable {
    let artwork: SongArtWork
    let name: String
}

// MARK: - Artwork
struct SongArtWork: Codable {
    let url: String
}

