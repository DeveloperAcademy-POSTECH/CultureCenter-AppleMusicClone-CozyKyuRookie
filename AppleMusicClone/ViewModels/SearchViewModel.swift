//
//  SearchViewModel.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    private var PlaylistsCancellable: AnyCancellable?
    private var SongsCancellable: AnyCancellable?
    private var ArtistsCancellable: AnyCancellable?
    private var HintsCancellable: AnyCancellable?
    
    @Published var hints: [commonViewModel<HintSuggestion>] = []
    @Published var playlists: [commonViewModel<PlaylistSuggestion>] = []
    @Published var artists: [commonViewModel<ArtistSuggestion>] = []
    @Published var songs: [commonViewModel<SongSuggestion>] = []
    
    func fetch(_ text: String) {
        HintsCancellable = WebService.searchTask(resource: Resource<Hint>(urlString: getHintsUrlString(text)))
            .catch { _ in Just(Hint.placeholder())}
            .sink(receiveValue: { hints in
                self.hints = hints.results.suggestions.map{ commonViewModel.init(suggestion: $0)}
            })
        
        SongsCancellable = WebService.searchTask(resource: Resource<Song>(urlString: getSongsUrlString(text)))
            .catch { _ in Just(Song.placeholder())}
            .sink(receiveValue: { songs in
                self.songs = songs.results.suggestions.map{ commonViewModel.init(suggestion: $0)}
            })
        
        ArtistsCancellable = WebService.searchTask(resource: Resource<Artist>(urlString: getArtistsUrlString(text)))
            .catch { _ in Just(Artist.placeholder())}
            .sink(receiveValue: { artists in
                self.artists = artists.results.suggestions.map{ commonViewModel.init(suggestion: $0)}
            })
        
        PlaylistsCancellable = WebService.searchTask(resource: Resource<Playlist>(urlString: getPlaylistsUrlString(text)))
            .catch { _ in Just(Playlist.placeholder())}
            .sink(receiveValue: { playlists in
                self.playlists = playlists.results.suggestions.map{ commonViewModel.init(suggestion: $0)}
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
        case let hint as HintSuggestion :
            inform = hint.displayTerm
        case let songs as SongSuggestion:
            inform = songs.content.attributes.name
            imageUrl = getImageUrl(urlString: songs.content.attributes.artwork.url)
        case let artist as ArtistSuggestion:
            inform = artist.content.attributes.name
            imageUrl = getImageUrl(urlString: artist.content.attributes.artwork.url)
            
        case let playlist as PlaylistSuggestion:
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
