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
    @StateObject var vmForHints: CombineViewModel = CombineViewModel()
    @StateObject var vmForPlaylists: CombineViewModel4 = CombineViewModel4()
    @StateObject var vmForArtists: CombineViewModel3 = CombineViewModel3()
    @StateObject var vmForSongs: CombineViewModel2 = CombineViewModel2()
    
    var body: some View {
        
        VStack {
            
            TextField("Your Location", text: $location)
                        .onChange(of: location) { _ in
                            self.vmForHints.fetchData(text: location)
                            self.vmForSongs.fetchData(text: location)
                            self.vmForArtists.fetchData(text: location)
                            self.vmForPlaylists.fetchData(text: location)
                        }
                        .padding()
            Rectangle()
                .frame(height:3)
                .padding()
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    LazyVStack {
                        
                        ForEach(vmForHints.welcome.results.suggestions.indices, id: \.self) { index in
                            Text(vmForHints.welcome.results.suggestions[index].displayTerm)
                        }
                    }
                    Rectangle()
                        .frame(height:3)
                        .padding()
                    
                    //songs
                    LazyVStack {
                        Text("songs")
                        ForEach(vmForSongs.welcome.results.suggestions.indices, id: \.self) { index in
                            
                            HStack {
                              
                                AsyncImage(url: vmForSongs.getImageUrl(index: index)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
                                
                                Text(vmForSongs.welcome.results.suggestions[index].content.attributes.name)
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
                        ForEach(vmForPlaylists.welcome.results.suggestions.indices, id: \.self) { index in
                            
                            
                            HStack {
                              
                                AsyncImage(url: vmForPlaylists.getImageUrl(index: index)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
                                
                                Text(vmForPlaylists.welcome.results.suggestions[index].content.attributes.name)
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
                        ForEach(vmForArtists.welcome.results.suggestions.indices, id: \.self) { index in
                            HStack {
                              
                                AsyncImage(url: vmForArtists.getImageUrl(index: index)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
                                
                                Text(vmForArtists.welcome.results.suggestions[index].content.attributes.name)
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
        SearchView(vmForHints: CombineViewModel(), vmForPlaylists: CombineViewModel4(), vmForArtists: CombineViewModel3(), vmForSongs: CombineViewModel2())
//        SearchView()
    }
}

class CombineViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?// View에 선언할 경우 내부에서 바뀌어야하는데 그러려면 state등을 해서 선언해야함
    
    @Published var welcome: WelcomeHints = WelcomeHints.placeholder()//모델에다가
    
    func fetchData(text: String) {
        self.cancellable = API.getDataWithCombine(text: text)
            .catch { _ in Just(WelcomeHints.placeholder())}
            .assign(to: \.welcome, on: self)//아래거 가능//class만 가능하므로 뷰모델이 class.
//            .sink(receiveCompletion: {_ in}, receiveValue: { welcome in
//                self.welcome = welcome
//                print(welcome)
//            })
    }
}

class CombineViewModel4: ObservableObject {
    
    private var cancellable: AnyCancellable?// View에 선언할 경우 내부에서 바뀌어야하는데 그러려면 state등을 해야하므로 좀 이상
    
    @Published var welcome: Welcome4 = Welcome4.placeholder()//모델에다가
    
    func fetchData(text: String) {
        self.cancellable = API.getDataWithCombinePlaylists(text: text)
            .catch { _ in Just(Welcome4.placeholder())}
            .print("?")
            .assign(to: \.welcome, on: self)//아래거 가능//class만 가능하므로 뷰모델이 class.

    }
    
    func getImageUrl(index: Int) -> URL? {
        //        "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/02/32/09/02320995-35fb-e63f-fb52-76595b70ed45/1.jpg/{w}x{h}bb.jpg"
                var path  = welcome.results.suggestions[index].content.attributes.artwork.url
                path = path.replacingOccurrences(of: "{w}", with: "100")
                path = path.replacingOccurrences(of: "{h}", with: "100")
                
                guard let encodedString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    return nil
        //            fatalError("Invalid encodedString")
                }
                guard let url = URL(string: encodedString) else {
                    return nil
        //            fatalError("Invalid URL")
                }
                return url
            }
    
}

class CombineViewModel3: ObservableObject {
    
    private var cancellable: AnyCancellable?// View에 선언할 경우 내부에서 바뀌어야하는데 그러려면 state등을 해야하므로 좀 이상
    
    @Published var welcome: Welcome3 = Welcome3.placeholder()//모델에다가
    
    func fetchData(text: String) {
        self.cancellable = API.getDataWithCombineArtists(text: text)
            .catch { _ in Just(Welcome3.placeholder())}
            .print()
            .assign(to: \.welcome, on: self)//아래거 가능//class만 가능하므로 뷰모델이 class.
//            .sink(receiveCompletion: {_ in}, receiveValue: { welcome in
//                self.welcome = welcome
//                print(welcome)
//            })
    }
    
    func getImageUrl(index: Int) -> URL? {
        //        "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/02/32/09/02320995-35fb-e63f-fb52-76595b70ed45/1.jpg/{w}x{h}bb.jpg"
                var path  = welcome.results.suggestions[index].content.attributes.artwork.url
                path = path.replacingOccurrences(of: "{w}", with: "100")
                path = path.replacingOccurrences(of: "{h}", with: "100")
                
                guard let encodedString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    return nil
        //            fatalError("Invalid encodedString")
                }
                guard let url = URL(string: encodedString) else {
                    return nil
        //            fatalError("Invalid URL")
                }
                return url
            }
    
    
}

class CombineViewModel2: ObservableObject {
    
    private var cancellable: AnyCancellable?// View에 선언할 경우 내부에서 바뀌어야하는데 그러려면 state등을 해야하므로 좀 이상
    
    @Published var welcome: Welcome2 = Welcome2.placeholder()//모델에다가
    
    func getImageUrl(index: Int) -> URL? {
        var path  = welcome.results.suggestions[index].content.attributes.artwork.url
        
        path = path.replacingOccurrences(of: "{w}", with: "100")
        path = path.replacingOccurrences(of: "{h}", with: "100")
        
        guard let encodedString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
//            fatalError("Invalid encodedString")
        }
        guard let url = URL(string: encodedString) else {
            return nil
//            fatalError("Invalid URL")
        }
        return url
    }
    func fetchData(text: String) {
        self.cancellable = API.getDataWithCombineSongs(text: text)
            .catch { _ in Just(Welcome2.placeholder())}
            .print()
            .assign(to: \.welcome, on: self)//아래거 가능//class만 가능하므로 뷰모델이 class.
//            .sink(receiveCompletion: {_ in}, receiveValue: { welcome in
//                self.welcome = welcome
//                print(welcome)
//            })
    }
}

