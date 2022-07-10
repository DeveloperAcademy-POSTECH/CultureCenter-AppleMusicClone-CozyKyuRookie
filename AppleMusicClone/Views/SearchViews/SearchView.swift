//
//  SearchView.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import SwiftUI
import Combine

struct SearchView: View {
    
    @State private var isSearching: Bool = false
    @State private var selectedScopeIndex : Int = 0
    @State private var searchText: String = ""
    @StateObject private var searchViewModel: SearchViewModel = SearchViewModel()

    var body: some View {
        
        NavigationView {
            VStack(spacing: -25) {
                SearchBar(isSearching: $isSearching, selectedScope: $selectedScopeIndex, text: $searchText, content: {})
                    .frame(height: 0)
                    .padding()
                    .onChange(of: searchText) { _ in
                        searchViewModel.fetch(searchText)
                    }
                ScrollView(.vertical) {
                    if isSearching == true && searchText.count == 0 {
                        Text("최근 검색한 항목")
                            .padding(.leading, 20)
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    }
                    
                    if searchText.count > 0 && selectedScopeIndex == 0 {
                        HintRow(searchViewModel: searchViewModel)
                        SongRow(searchViewModel: searchViewModel)
                        PlaylistRow(searchViewModel: searchViewModel)
                        ArtistRow(searchViewModel: searchViewModel)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationTitle("검색")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension SearchView {
    enum searchCategory: String, CaseIterable {
        case appleMusic = "Apple Music"
        case store = "보관함"
    }
}


