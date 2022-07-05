//
//  Playlist.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

extension Welcome4 {
    static func placeholder() -> Welcome4 {
        Welcome4(results: Results4(suggestions: [Suggestion4(kind: "", content: Content4(id: "", type: "", href: "", attributes: Attributes4(playParams: PlayParams4(id: "", kind: "", versionHash: ""), url: "", isChart: false, curatorName: "", artwork: Artwork4(width: 3, height: 3, url: "", bgColor: "", textColor1: "", textColor2: "", textColor3: "", textColor4: ""), playlistType: "", name: "playlist은 없다", lastModifiedDate: "Date()",description: nil)))]))
    }
}

// MARK: - Welcome
struct Welcome4: Codable {
    let results: Results4
}

// MARK: - Results
struct Results4: Codable {
    let suggestions: [Suggestion4]
}

// MARK: - Suggestion
struct Suggestion4: Codable {
    let kind: String
    let content: Content4
}

// MARK: - Content
struct Content4: Codable {
    let id, type, href: String
    let attributes: Attributes4
}

// MARK: - Attributes
struct Attributes4: Codable {
    let playParams: PlayParams4
    let url: String
    let isChart: Bool
    let curatorName: String
    let artwork: Artwork4
    let playlistType, name: String
    let lastModifiedDate: String// quick type 상으로는 Date 인데 실제로 string이므로 출력안되었었다.
    let description: Description?
}

// MARK: - Artwork
struct Artwork4: Codable {
    let width, height: Int
    let url, bgColor, textColor1, textColor2: String
    let textColor3, textColor4: String
}

// MARK: - PlayParams
struct PlayParams4: Codable {
    let id, kind, versionHash: String
}

struct Description: Codable {
    let standard, short: String
}
