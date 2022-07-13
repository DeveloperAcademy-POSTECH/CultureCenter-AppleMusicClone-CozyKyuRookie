//
//  SearchResultCategoriesView.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/13.
//

import SwiftUI
//
//
//
//  %^&^%$^&^%%&&^%$^&^%%^ 아직 보지마시오.@!@@#!!$@#%#$^%^^&^&(*(*()*&^%$#$%^&*(*$#$%^&*
//
//
//
//
//
struct SearchResultCategoriesView: View {
    @State private var selectedSection = SearchDetailCategory.popular
    var body: some View {
        Picker("Selected section:", selection: $selectedSection) {
            ForEach(SearchDetailCategory.allCases, id:\.self) { text in
                Text(text.rawValue)
                    .tag(text)
            }
        }
        .pickerStyle(.segmented)
        .padding()
        
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//                ForEach(SearchDetailCategory.allCases, id: \.self) { category in
//                    Text(category.rawValue)
//                }
//            }
//        }
    }
}

private enum SearchDetailCategory: String, CaseIterable {
    case popular = "인기 검색 결과"
    case artist = "아티스트"
    case album = "앨범"
    case song = "노래"
    case playlist = "플레이리스트"
    case musicVideo = "뮤직비디오"
    case video = "비디오 Extras"
}

struct SearchResultCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultCategoriesView()
    }
}
