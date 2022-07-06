//
//  Artist.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

struct Welcome3: Codable {
    let results: Results3
}

extension Welcome3 {
    static func placeholder() -> Welcome3 {
        Welcome3(results: Results3(suggestions: [Suggestion3(kind: "", content: Content3(id: "", type: "", href: "", attributes: Attributes3(name: "artist은 없다", genreNames: [""], artwork: Artwork3(width: 3, height: 3, url: "", bgColor: "", textColor1: "", textColor2: "", textColor3: "", textColor4: ""), url: ""), relationships: Relationships3(albums: Albums3(href: "", next: "", data: [Datum3(id: "", type: TypeEnum3.albums, href: "")]))))]))
    }
}
// MARK: - Results
struct Results3: Codable {
    let suggestions: [Suggestion3]
}

// MARK: - Suggestion
struct Suggestion3: Codable {
    let kind: String
    let content: Content3
}

// MARK: - Content
struct Content3: Codable {
    let id, type, href: String
    let attributes: Attributes3
    let relationships: Relationships3
}

// MARK: - Attributes
struct Attributes3: Codable {
    let name: String
    let genreNames: [String]
    let artwork: Artwork3
    let url: String
}

// MARK: - Artwork
struct Artwork3: Codable {
    let width, height: Int
    let url, bgColor, textColor1, textColor2: String
    let textColor3, textColor4: String
}

// MARK: - Relationships
struct Relationships3: Codable {
    let albums: Albums3
}

// MARK: - Albums
struct Albums3: Codable {
    let href: String
    let next: String?
    // optional 안하면 안나옴
    let data: [Datum3]
}

// MARK: - Datum
struct Datum3: Codable {
    let id: String
    let type: TypeEnum3
    let href: String
}

enum TypeEnum3: String, Codable {
    case albums = "albums"
}
