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
        return SongResponse(results: SongResult(suggestions: [SongSuggestion(content: SongContent(attributes: SongAttributes(previews: [SongPreview(url: "")], artwork: SongArtWork(url: ""), name: "")))]))
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
    let previews: [SongPreview]
    let artwork: SongArtWork
    let name: String
}

// MARK: - Preview
struct SongPreview: Codable {
    let url: String
}

// MARK: - Artwork
struct SongArtWork: Codable {
    let url: String
}

