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

struct WebService {
    
    static func searchData<T>(resource: Resource<T>) -> AnyPublisher<T, Error> {
        
        let urlString = resource.urlString.replacingOccurrences(of: " ", with: "+")
//        let urlString = urlString2.replacingOccurrences(of: " ", with: "+")
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            //TODO: Error 처리
            fatalError("Invalid encodedString")
        }
        guard let url = URL(string: encodedString) else {
            fatalError("Invalid URL")
        }
        var getRequest = URLRequest(url: url)
    
        getRequest.addValue("Bearer \(Secret.token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: getRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

extension WebService {
    
    static func getDataWithCombine(text: String) -> AnyPublisher<WelcomeHints, Error> {

        let urlString = "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=terms"

        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError("Invalid encodedString")
        }
        guard let url = URL(string: encodedString) else {
            fatalError("Invalid URL")
        }
        
        var getRequest = URLRequest(url: url)
    
        getRequest.addValue("Bearer \(Secret.token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: getRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
//            .map{$0.data}//이거도 가능
            .decode(type: WelcomeHints.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}

extension WebService {
    
    static func getDataWithCombineArtists(text: String) -> AnyPublisher<Welcome3, Error> {

        let urlString2 = "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=artists&limit=7"
        
        let urlString = urlString2.replacingOccurrences(of: " ", with: "+")
        // limit 10 하면 p 등 안나온다.
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError("Invalid encodedString")
        }
        guard let url = URL(string: encodedString) else {
            fatalError("Invalid URL")
        }

        var getRequest = URLRequest(url: url)

        getRequest.addValue("Bearer \(Secret.token)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: getRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Welcome3.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}

extension WebService {
    static func getDataWithCombinePlaylists(text: String) -> AnyPublisher<Welcome4, Error> {
        
        //kr로 안하면 아이유 안나옴
        let urlString2 =
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=playlists"
        
        let urlString = urlString2.replacingOccurrences(of: " ", with: "+")
        // limit 10 하면 p 등 안나온다.
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError("Invalid encodedString")
        }
        guard let url = URL(string: encodedString) else {
            fatalError("Invalid URL")
        }

        var getRequest = URLRequest(url: url)
        getRequest.addValue("Bearer \(Secret.token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: getRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Welcome4.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension WebService {
    
    static func getDataWithCombineSongs(text: String) -> AnyPublisher<Welcome2, Error> {
        
        let urlString2 = "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=songs&limit=7"
        let urlString = urlString2.replacingOccurrences(of: " ", with: "+")
        // limit 10 하면 p 등 안나온다.
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError("Invalid encodedString")
        }
        guard let url = URL(string: encodedString) else {
            fatalError("Invalid URL")
        }

        var getRequest = URLRequest(url: url)

        getRequest.addValue("Bearer \(Secret.token)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: getRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Welcome2.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
