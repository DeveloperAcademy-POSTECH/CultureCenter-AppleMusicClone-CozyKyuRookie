//
//  Webservice.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation
import Combine

struct Resource<T: Codable> {
    let urlString: String
}
protocol Webservice {
    static func searchTask<Thema>(resource: Resource<Thema>) -> AnyPublisher<Thema, Error>
}

struct MediaSearchService: Webservice {
    static func searchTask<Thema>(resource: Resource<Thema>) -> AnyPublisher<Thema, Error> {
        let urlString = resource.urlString.replacingOccurrences(of: " ", with: "+")
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            //TODO: Error 처리
            fatalError("Invalid encodedString")
        }
        guard let url = URL(string: encodedString) else {
            fatalError("Invalid URL")
        }
        var fetchRequest = URLRequest(url: url)
        fetchRequest.addValue("Bearer \(Secret.token)", forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: fetchRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Thema.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

//TODO: for test
//struct FakeSearchService: Webservice {
//    static func searchTask<Thema>(resource: Resource<Thema>) -> AnyPublisher<Thema, Error> where Thema : Codable {
//        
//        switch Thema.self {
//        case _ as HintResponse.Type:
//            return Just(HintResponse(results: HintResult(suggestions: [HintSuggestion(displayTerm: "아에이오우")])))
//                .tryMap{$0 as! Thema}.eraseToAnyPublisher()
//        case _ as SongResponse.Type:
//            return Just(SongResponse(results: SongResult(suggestions: [SongSuggestion(content: SongContent(attributes: SongAttributes(artwork: SongArtWork(url: "asdvsdv"), name: "xbfbadfb")))])))
//                .tryMap{$0 as! Thema}.eraseToAnyPublisher()
//        case _ as ArtistResponse.Type:
//            return Just(ArtistResponse(results: ArtistResult(suggestions: [ArtistSuggestion(content: ArtistContent(attributes: ArtistAttributes(name: "asdvasdv", artwork: ArtistArtwork(url: "sdad"))))])))
//                .tryMap{$0 as! Thema}.eraseToAnyPublisher()
//        case _ as PlaylistResponse.Type:
//            return Just(PlaylistResponse(results: PlaylistResult(suggestions: [PlaylistSuggestion(content: PlaylistContent(attributes: PlaylistAttribute(artwork: PlaylistArtwork(url: ""), name: "asdvasdv")))])))
//                .tryMap{$0 as! Thema}.eraseToAnyPublisher()
//        default :
//            return Just(HintResponse(results: HintResult(suggestions: [HintSuggestion(displayTerm: "아에이오우")])))
//                .tryMap{$0 as! Thema}.eraseToAnyPublisher()
//        }
//    }
//    
//    
//}

