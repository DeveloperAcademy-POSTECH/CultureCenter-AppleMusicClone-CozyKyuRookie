//
//  Constants.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/04.
//

import Foundation

// Constant 한 값들(예를들어 아래와 같은 url)을 위해 사용하면 될 것 같습니다.
// 예시) Constants.URLs.getSuggestionTemrs("아이유")

struct Constants {
    enum URLs {
        static func getSuggestionTerms(text: String) -> String {
            "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=terms"
        }
    }
}
