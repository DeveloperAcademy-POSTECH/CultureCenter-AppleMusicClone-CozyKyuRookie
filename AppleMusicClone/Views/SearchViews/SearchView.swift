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

    @StateObject var searchVM: SearchViewModel = SearchViewModel()
    
    var body: some View {
        
        VStack {
            
            TextField("Your Location", text: $location)
                        .onChange(of: location) { _ in
                            
                            searchVM.fetch(location)
                            
                        }
                        .padding()
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    LazyVStack {
                        Text("Hints")
                        ForEach(
                            searchVM.hints3.indices
                            , id: \.self) { index in
                            Text(searchVM.hints3[index].inform)
                        }
                    }
                    Rectangle()
                        .frame(height:3)
                        .padding()
                    //songs
                    LazyVStack {
                        Text("songs")
                        ForEach(searchVM.songs3.indices, id: \.self) { index in
                            HStack {
                                AsyncImage(url:searchVM.songs3[index].imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
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
                        ForEach(searchVM.playlists3.indices, id: \.self) { index in
                            HStack {
                                AsyncImage(url: searchVM.playlists3[index].imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
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
                        ForEach(searchVM.artists3.indices, id: \.self) { index in
                            HStack {
                                AsyncImage(url:
                                            searchVM.artists3[index].imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "circle")
                                }
                                .frame(width: 50, height: 50)
                                
                                Text(
                                    searchVM.artists3[index].inform)
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




