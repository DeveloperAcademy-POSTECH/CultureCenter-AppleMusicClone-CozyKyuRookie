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


