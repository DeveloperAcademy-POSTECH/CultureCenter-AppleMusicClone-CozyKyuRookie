//
//  SearchView.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/05.
//

import Combine
import SwiftUI

struct SearchView: View {
    @State private var isSearching: Bool = false
    @State private var selectedScope: SearchCategory = .appleMusic
    @State private var searchText: String = ""
    @StateObject private var searchViewModel: SearchViewModel = .init()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(isSearching: $isSearching, selectedScope: $selectedScope, text: $searchText)
                    .frame(height: 0)
                    .onChange(of: searchText) { _ in
                        searchViewModel.fetch(searchText)
                    }

                ScrollView(.vertical) {
                    if isSearching == true {
                        switch selectedScope {
                        case .appleMusic where searchText.isEmpty:
                            Text("최근 검색한 항목")
                                .padding(.leading, 20)
                                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        case .appleMusic:
                            HintRow(searchViewModel: searchViewModel)
                            SongRow(searchViewModel: searchViewModel)
                            PlaylistRow(searchViewModel: searchViewModel)
                            ArtistRow(searchViewModel: searchViewModel)
                        case .store where searchText.isEmpty:
                            Text("최근 검색한 항목")
                                .padding(.leading, 20)
                                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        case .store:
                            Text("유저의 보관함 리스트")
                        }
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
