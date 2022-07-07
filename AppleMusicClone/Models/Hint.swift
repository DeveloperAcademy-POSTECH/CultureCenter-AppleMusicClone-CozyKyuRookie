//
//  Hint.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

// MARK: - Welcome
struct Hint: Codable {
    let results: HintResult
}
extension Hint {
    static func placeholder() ->  Hint {
        Hint(results: HintResult(suggestions: [HintSuggestion(kind: "", searchTerm: "", displayTerm: "")]))
    }
}

// MARK: - Results
struct HintResult: Codable {
    let suggestions: [HintSuggestion]
}

// MARK: - Suggestion
struct HintSuggestion: Codable {
    let kind, searchTerm, displayTerm: String
}
