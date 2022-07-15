//
//  Artist.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

// MARK: - Artist

struct ArtistResponse: Codable {
    let results: ArtistResult
}

extension ArtistResponse {
    static func placeholder() -> ArtistResponse {
        ArtistResponse(results: ArtistResult(suggestions: [ArtistSuggestion(content: ArtistContent(attributes: ArtistAttributes(name: "asdasd", artwork: ArtistArtwork(url: ""))))]))
    }
}

// MARK: - Results

struct ArtistResult: Codable {
    let suggestions: [ArtistSuggestion]
}

// MARK: - Suggestion

struct ArtistSuggestion: Codable {
    let content: ArtistContent
}

// MARK: - Content

struct ArtistContent: Codable {
    let attributes: ArtistAttributes
}

// MARK: - Attributes

struct ArtistAttributes: Codable {
    let name: String
    let artwork: ArtistArtwork
}

// MARK: - Artwork

struct ArtistArtwork: Codable {
    let url: String
}
