//
//  Song.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

struct Welcome2: Codable {
    let results: Results2
}

extension Welcome2 {
    static func placeholder() -> Welcome2 {
        return Welcome2(results: Results2(suggestions: [Suggestion2(kind: "", content: Content2(id: "", type: "", href: "", attributes: Attributes2(previews: [Preview2(url: "")], artwork: Artwork2(width: 1, height: 1, url: "", bgColor: "", textColor1: "", textColor2: "", textColor3: "", textColor4: ""), artistName: "", url: "", discNumber: 3, genreNames: [""], durationInMillis: 3, releaseDate: "", isAppleDigitalMaster: false, name: "song은 없다", isrc: "", hasLyrics: false, albumName: "", playParams: PlayParams2(id: "", kind: ""), trackNumber: 3, composerName: "")))]))
    }
}

// MARK: - Results
struct Results2: Codable {
    let suggestions: [Suggestion2]
}

// MARK: - Suggestion
struct Suggestion2: Codable {
    let kind: String
    let content: Content2
}

// MARK: - Content
struct Content2: Codable {
    let id, type, href: String
    let attributes: Attributes2
}

// MARK: - Attributes
struct Attributes2: Codable {
    let previews: [Preview2]
    let artwork: Artwork2
    let artistName: String
    let url: String
    let discNumber: Int
    let genreNames: [String]
    let durationInMillis: Int
    let releaseDate: String?
    let isAppleDigitalMaster: Bool
    let name, isrc: String
    let hasLyrics: Bool
    let albumName: String
    let playParams: PlayParams2
    let trackNumber: Int
    let composerName: String?// 데이터마다 이 프로퍼티가 있는 것이 있고 없는것이 있다. 옵셔널이 아니라면 못가져온다.
}

// MARK: - Artwork
struct Artwork2: Codable {
    let width, height: Int
    let url, bgColor, textColor1, textColor2: String
    let textColor3, textColor4: String
}

// MARK: - PlayParams
struct PlayParams2: Codable {
    let id, kind: String
}

// MARK: - Preview
struct Preview2: Codable {
    let url: String
}

