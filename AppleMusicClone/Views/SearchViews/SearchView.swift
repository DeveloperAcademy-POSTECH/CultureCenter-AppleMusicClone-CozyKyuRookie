//
//  SearchView.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import SwiftUI
import Combine

struct SearchView: View {
    
    @State private var location = ""
//    @StateObject var vmForHints: CombineViewModel = CombineViewModel()
//    @StateObject var vmForPlaylists: CombineViewModel4 = CombineViewModel4()
//    @StateObject var vmForArtists: CombineViewModel3 = CombineViewModel3()
//    @StateObject var vmForSongs: CombineViewModel2 = CombineViewModel2()
    
    @StateObject var searchVM: SearchViewModel = SearchViewModel()
    
    var body: some View {
        
        VStack {
            
            TextField("Your Location", text: $location)
                        .onChange(of: location) { _ in
                            
//                            self.vmForHints.fetchData(text: location)
//                            self.vmForSongs.fetchData(text: location)
//                            self.vmForArtists.fetchData(text: location)
//                            self.vmForPlaylists.fetchData(text: location)
                            
//                            searchVM.fetchData(location)
                            
                            searchVM.fetch(location)
                            
                        }
                        .padding()
            
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    LazyVStack {
                        Text("Hints")
                        ForEach(
//                            searchVM.hints.results.suggestions.indices
                            searchVM.hints3.indices
                            , id: \.self) { index in
                            Text(
//                                searchVM.hints.results.suggestions[index].displayTerm
                                searchVM.hints3[index].inform
                            )
                        }
                    }
                    Rectangle()
                        .frame(height:3)
                        .padding()
                    
                    //songs
                    LazyVStack {
                        Text("songs")
                        ForEach(
//                            searchVM.songs.results.suggestions.indices
                            searchVM.songs3.indices
                            , id: \.self) { index in
                            
                            HStack {
                              
                                AsyncImage(url:
//                                            searchVM.getImageUrl(urlString: searchVM.songs.results.suggestions[index].content.attributes.artwork.url)
                                           searchVM.songs3[index].imageUrl
                                ) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
                                
//                                Text(searchVM.songs.results.suggestions[index].content.attributes.name)
                                Text(searchVM.songs3[index].inform)
                                Spacer()
                            }
                            
                            
                            
                        }
                    }
                    Rectangle()
                        .frame(height:3)
                        .padding()
                    //playlists
                    LazyVStack {
                        Text("playlists")
                        ForEach(
//                            searchVM.playlists.results.suggestions.indices
                            searchVM.playlists3.indices
                                , id: \.self) { index in
                            
                            
                            HStack {
                              
                                AsyncImage(url:
                                            searchVM.playlists3[index].imageUrl
//                                            searchVM.getImageUrl(urlString: searchVM.playlists.results.suggestions[index].content.attributes.artwork.url)
                                ) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
                                
//                                Text(searchVM.playlists.results.suggestions[index].content.attributes.name)
                                Text(searchVM.playlists3[index].inform)
                                Spacer()
                            }
                        }
                    }
                    Rectangle()
                        .frame(height:3)
                        .padding()
                    //artist
                    LazyVStack {
                        Text("artists")
                        ForEach(
//                            searchVM.artists.results.suggestions.indices
                            searchVM.artists3.indices
                            , id: \.self) { index in
                            HStack {
                              
                                AsyncImage(url:
                                            searchVM.artists3[index].imageUrl
//                                            searchVM.getImageUrl(urlString:
//                                                                        searchVM.artists.results.suggestions[index].content.attributes.artwork.url
//                                                                     searchVM.artists3[index].urlString)
                                ) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
                                
                                Text(
                                    searchVM.artists3[index].inform
//                                    searchVM.artists.results.suggestions[index].content.attributes.name
                                )
                                Spacer()
                            }
                            
                            
                        }
                    }
                    
                }
            }
            
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


//searchVM.playlists.results.suggestions[index].content.attributes.artwork.url

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
        //        "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/02/32/09/02320995-35fb-e63f-fb52-76595b70ed45/1.jpg/{w}x{h}bb.jpg"
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

class SearchViewModel: ObservableObject {
    
    private var cancellableForPlaylists: AnyCancellable?
    private var cancellableForSongs: AnyCancellable?
    private var cancellableForArtists: AnyCancellable?
    private var cancellableForHints: AnyCancellable?
    
    @Published var hints3: [commonViewModel<SuggestionHints>] = []
    @Published var playlists3: [commonViewModel<Suggestion4>] = []
    @Published var artists3: [commonViewModel<Suggestion3>] = []
    @Published var songs3: [commonViewModel<Suggestion2>] = []
    
//    @Published var hints: WelcomeHints = WelcomeHints.placeholder()
//    @Published var playlists: Welcome4 = Welcome4.placeholder()
//    @Published var artists: Welcome3 = Welcome3.placeholder()
//    @Published var songs: Welcome2 = Welcome2.placeholder()
    
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
    
    
//    func fetchData(_ text: String) {
//        self.cancellableForHints = WebService.searchData(resource: Resource<WelcomeHints>(urlString: getHintsUrlString(text)))
//            .catch { _ in Just(WelcomeHints.placeholder())}
//            .assign(to: \.hints, on: self)
//        
//        self.cancellableForSongs = WebService.searchData(resource: Resource<Welcome2>(urlString: getSongsUrlString(text)))
//            .catch { _ in Just(Welcome2.placeholder())}
//            .assign(to: \.songs, on: self)
//        
//        self.cancellableForArtists = WebService.searchData(resource: Resource<Welcome3>(urlString: getArtistsUrlString(text)))
//            .catch { _ in Just(Welcome3.placeholder())}
//            .assign(to: \.artists, on: self)
//        
//        self.cancellableForPlaylists = WebService.searchData(resource: Resource<Welcome4>(urlString: getPlaylistsUrlString(text)))
//            .catch { _ in Just(Welcome4.placeholder())}
//            .assign(to: \.playlists, on: self)
//        
//    }
    
    func getImageUrl(urlString: String) -> URL? {
        //        "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/02/32/09/02320995-35fb-e63f-fb52-76595b70ed45/1.jpg/{w}x{h}bb.jpg"
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



