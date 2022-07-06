//
//  Hint.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

// MARK: - Welcome
struct WelcomeHints: Codable {
    let results: ResultsHints
}
extension WelcomeHints {
    static func placeholder() ->  WelcomeHints {
        WelcomeHints(results: ResultsHints(suggestions: [SuggestionHints(kind: "", searchTerm: "", displayTerm: "")]))
    }
}

// MARK: - Results
struct ResultsHints: Codable {
    let suggestions: [SuggestionHints]
}

// MARK: - Suggestion
struct SuggestionHints: Codable {
    let kind, searchTerm, displayTerm: String
}
