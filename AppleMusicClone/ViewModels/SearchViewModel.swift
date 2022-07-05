//
//  SearchViewModel.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    private var cancellableForPlaylists: AnyCancellable?
    private var cancellableForSongs: AnyCancellable?
    private var cancellableForArtists: AnyCancellable?
    private var cancellableForHints: AnyCancellable?
    
    @Published var hints3: [commonViewModel<SuggestionHints>] = []
    @Published var playlists3: [commonViewModel<Suggestion4>] = []
    @Published var artists3: [commonViewModel<Suggestion3>] = []
    @Published var songs3: [commonViewModel<Suggestion2>] = []
    
    func fetch(_ text: String) {
        
        self.cancellableForHints = WebService.searchData(resource: Resource<WelcomeHints>(urlString: getHintsUrlString(text)))
            .catch { _ in Just(WelcomeHints.placeholder())}
            .sink(receiveValue: { hints in
                self.hints3 = hints.results.suggestions.map{ commonViewModel.init(suggestion: $0)}
            })
        
        self.cancellableForSongs = WebService.searchData(resource: Resource<Welcome2>(urlString: getSongsUrlString(text)))
            .catch { _ in Just(Welcome2.placeholder())}
            .sink(receiveValue: { songs in
                self.songs3 = songs.results.suggestions.map{ commonViewModel.init(suggestion: $0)}
            })
        
        self.cancellableForArtists = WebService.searchData(resource: Resource<Welcome3>(urlString: getArtistsUrlString(text)))
            .catch { _ in Just(Welcome3.placeholder())}
            .sink(receiveValue: { artists in
                self.artists3 = artists.results.suggestions.map{ commonViewModel.init(suggestion: $0)}
            })
        self.cancellableForPlaylists = WebService.searchData(resource: Resource<Welcome4>(urlString: getPlaylistsUrlString(text)))
            .catch { _ in Just(Welcome4.placeholder())}
            .sink(receiveValue: { playlists in
                self.playlists3 = playlists.results.suggestions.map{ commonViewModel.init(suggestion: $0)}
            })
    }
}

extension SearchViewModel {
    
    private func getHintsUrlString(_ text: String) -> String {
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=terms"
    }
    private func getSongsUrlString(_ text: String) -> String {
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=songs&limit=7"
    }
    private func getArtistsUrlString(_ text: String) -> String {
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=artists&limit=7"
    }
    private func getPlaylistsUrlString(_ text: String) -> String {
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=playlists"
    }
    
}

struct commonViewModel<T> {
    
    let suggestion: T
    let inform: String
    var imageUrl: URL?
    
    init(suggestion: T) {
        self.suggestion = suggestion
        switch suggestion {
        case let hint as SuggestionHints :
            inform = hint.displayTerm
        case let songs as Suggestion2:
            inform = songs.content.attributes.name
            imageUrl = getImageUrl(urlString: songs.content.attributes.artwork.url)
        case let artist as Suggestion3:
            inform = artist.content.attributes.name
            imageUrl = getImageUrl(urlString: artist.content.attributes.artwork.url)
            
        case let playlist as Suggestion4:
            inform = playlist.content.attributes.name
            imageUrl = getImageUrl(urlString: playlist.content.attributes.artwork.url)
        default:
            inform = ""
        }
    }
    private func getImageUrl(urlString: String) -> URL? {
        
        var path  = urlString
        path = path.replacingOccurrences(of: "{w}", with: "100")
        path = path.replacingOccurrences(of: "{h}", with: "100")
        guard let encodedString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        guard let url = URL(string: encodedString) else {
            return nil
        }
        return url
    }
}
