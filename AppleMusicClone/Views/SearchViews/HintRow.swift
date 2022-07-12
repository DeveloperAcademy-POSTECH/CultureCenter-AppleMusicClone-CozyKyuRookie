//
//  HintRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import SwiftUI

struct HintRow: View {
    
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var searchText: String
    
    var body: some View {
        
        LazyVStack(spacing: 0) {
            ForEach(searchViewModel.hints.indices, id: \.self) { index in
                let hintString = searchViewModel.hints[index].inform
                Button {
                    searchText = hintString
                } label: {
                    VStack(alignment: .leading, spacing: 15) {
                        Divider().opacity(index == 0 ? 1 : 0)
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text(hintString)
                        }
                        .foregroundColor(.black)
                        Divider()
                    }
                }
                .buttonStyle(grayClickStyle())
            }
        }
    }
}


