//
//  SearchViewModel.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    private var playlistsCancellable: AnyCancellable?
    private var songsCancellable: AnyCancellable?
    private var artistsCancellable: AnyCancellable?
    private var hintsCancellable: AnyCancellable?

    @Published var hints: [CommonViewModel<HintSuggestion>] = []
    @Published var playlists: [CommonViewModel<PlaylistSuggestion>] = []
    @Published var artists: [CommonViewModel<ArtistSuggestion>] = []
    @Published var songs: [CommonViewModel<SongSuggestion>] = []

    func fetch(_ text: String) {
        hintsCancellable = WebService.searchTask(resource: Resource<HintResponse>(urlString: getHintsURLString(text)))
            .catch { _ in Just(HintResponse.placeholder()) }
            .sink(receiveValue: { hintResponse in
                self.hints = hintResponse.results.suggestions.map { CommonViewModel.init(suggestion: $0) }
            })

        songsCancellable = WebService.searchTask(resource: Resource<SongResponse>(urlString: getSongsURLString(text)))
            .catch { _ in Just(SongResponse.placeholder()) }
            .sink(receiveValue: { songResponse in
                self.songs = songResponse.results.suggestions.map { CommonViewModel.init(suggestion: $0) }
            })

        artistsCancellable = WebService.searchTask(resource: Resource<ArtistResponse>(urlString: getArtistsURLString(text)))
            .catch { _ in Just(ArtistResponse.placeholder()) }
            .sink(receiveValue: { artistResponse in
                self.artists = artistResponse.results.suggestions.map { CommonViewModel.init(suggestion: $0) }
            })

        playlistsCancellable = WebService.searchTask(resource: Resource<PlaylistResponse>(urlString: getPlaylistsURLString(text)))
            .catch { _ in Just(PlaylistResponse.placeholder()) }
            .sink(receiveValue: { playlistResponse in
                self.playlists = playlistResponse.results.suggestions.map { CommonViewModel.init(suggestion: $0) }
            })
    }
}

extension SearchViewModel {
    private func getHintsURLString(_ text: String) -> String {
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=terms"
    }

    private func getSongsURLString(_ text: String) -> String {
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=songs&limit=7"
    }

    private func getArtistsURLString(_ text: String) -> String {
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=artists&limit=7"
    }

    private func getPlaylistsURLString(_ text: String) -> String {
        "https://api.music.apple.com/v1/catalog/kr/search/suggestions?term=\(text)&kinds=topResults&types=playlists"
    }
}

struct CommonViewModel<T> {
    let suggestion: T
    let inform: String
    var imageURL: URL?
    var songURL: URL?

    init(suggestion: T) {
        self.suggestion = suggestion
        switch suggestion {
        case let hint as HintSuggestion:
            inform = hint.displayTerm
        case let songs as SongSuggestion:
            inform = songs.content.attributes.name
            imageURL = getImageURL(urlString: songs.content.attributes.artwork.url)
            guard let url = songs.content.attributes.previews.first?.url else { return }
            songURL = URL(string: url)
        case let artist as ArtistSuggestion:
            inform = artist.content.attributes.name
            imageURL = getImageURL(urlString: artist.content.attributes.artwork.url)
        case let playlist as PlaylistSuggestion:
            inform = playlist.content.attributes.name
            imageURL = getImageURL(urlString: playlist.content.attributes.artwork.url)
        default:
            inform = ""
        }
    }

    private func getImageURL(urlString: String) -> URL? {
        var path = urlString
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
