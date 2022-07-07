//
//  Artist.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

struct Artist: Codable {
    let results: ArtistResult
}

extension Artist {
    static func placeholder() -> Artist {
        Artist(results: ArtistResult(suggestions: [ArtistSuggestion(kind: "", content: ArtistContent(id: "", type: "", href: "", attributes: ArtistAttributes(name: "artist은 없다", genreNames: [""], artwork: ArtistArtwork(width: 3, height: 3, url: "", bgColor: "", textColor1: "", textColor2: "", textColor3: "", textColor4: ""), url: ""), relationships: ArtistRelationships(albums: ArtistAlbums(href: "", next: "", data: [ArtistData(id: "", type: ArtistType.albums, href: "")]))))]))
    }
}
// MARK: - Results
struct ArtistResult: Codable {
    let suggestions: [ArtistSuggestion]
}

// MARK: - Suggestion
struct ArtistSuggestion: Codable {
    let kind: String
    let content: ArtistContent
}

// MARK: - Content
struct ArtistContent: Codable {
    let id, type, href: String
    let attributes: ArtistAttributes
    let relationships: ArtistRelationships
}

// MARK: - Attributes
struct ArtistAttributes: Codable {
    let name: String
    let genreNames: [String]
    let artwork: ArtistArtwork
    let url: String
}

// MARK: - Artwork
struct ArtistArtwork: Codable {
    let width, height: Int
    let url, bgColor, textColor1, textColor2: String
    let textColor3, textColor4: String
}

// MARK: - Relationships
struct ArtistRelationships: Codable {
    let albums: ArtistAlbums
}

// MARK: - Albums
struct ArtistAlbums: Codable {
    let href: String
    let next: String?
    let data: [ArtistData]
}

// MARK: - Datum
struct ArtistData: Codable {
    let id: String
    let type: ArtistType
    let href: String
}

enum ArtistType: String, Codable {
    case albums = "albums"
}
