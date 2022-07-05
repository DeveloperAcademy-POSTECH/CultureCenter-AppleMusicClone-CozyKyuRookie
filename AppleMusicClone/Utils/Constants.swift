//
//  Constants.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/04.
//

import Foundation

// Constant 한 값들(예를들어 아래와 같은 url)을 위해 사용하면 될 것 같습니다.
// 예시) Constants.Urls.getSuggestionTemrs("아이유")

struct Constants {
    
    struct Urls {
         
        static func getSuggestionTemrs(text: String) -> String {
            "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=terms"
            
        }
        
    }
    
}


//TODO: 추후 숨겨야 할 것 같습니다.
struct Secret {
    static let token: String = "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjRCWVhMSlY1M0IifQ.eyJpYXQiOjE2NTY0MDM0OTIsImV4cCI6MTY3MTk1NTQ5MiwiaXNzIjoiSDVQRDNQOTVGNSJ9.p3e6xK9OFpdIAwbhpN-Lqav9r42QZHRiPU8PoHIFJMBRtcQVLegLYM8XMpWoEMpn0SQnwHuUyKoht1vVEZ0IYw"
}
