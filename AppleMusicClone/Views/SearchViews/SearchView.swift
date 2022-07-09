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
    @State private var category: searchCategory = .appleMusic
    @StateObject var searchViewModel: SearchViewModel = SearchViewModel()
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 10) {
                ///TODO: 커스텀 텍스트 필드
                SearchBar(text: $location, content: {})
                    .frame(height: 0)
                    .padding()
                    .onChange(of: location) { _ in
                        searchViewModel.fetch(location)
                    }
                if location.count > 0 {
                    ScrollView(.vertical) {
                        HintRow(searchViewModel: searchViewModel)
                        SongRow(searchViewModel: searchViewModel)
                        PlaylistRow(searchViewModel: searchViewModel)
                        ArtistRow(searchViewModel: searchViewModel)
                    }
                    Spacer()
                }
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
    
    private func searchPicker() -> some View {
        
        Picker("category", selection: $category) {
            ForEach(searchCategory.allCases, id: \.self) { category in
                let categoryString = category.rawValue
                Text(categoryString).tag(categoryString)
            }
        }
        .pickerStyle(.segmented)
    }
}

extension SearchView {
    enum searchCategory: String, CaseIterable {
        case appleMusic = "Apple Music"
        case store = "보관함"
    }
}


