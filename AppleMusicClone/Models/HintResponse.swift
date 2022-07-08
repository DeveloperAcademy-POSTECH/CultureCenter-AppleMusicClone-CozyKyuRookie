//
//  Hint.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation

// MARK: - Hint
struct HintResponse: Codable {
    let results: HintResult
}

extension HintResponse {
    static func placeholder() ->  HintResponse {
        HintResponse(results: HintResult(suggestions: [HintSuggestion(displayTerm: "")]))
    }
}

// MARK: - Results
struct HintResult: Codable {
    let suggestions: [HintSuggestion]
}

// MARK: - Suggestion
struct HintSuggestion: Codable {
    let displayTerm: String
}
