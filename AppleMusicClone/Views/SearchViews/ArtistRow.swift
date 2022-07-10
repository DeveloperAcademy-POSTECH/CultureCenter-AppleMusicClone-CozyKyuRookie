//
//  ArtistRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import SwiftUI

struct ArtistRow: View {
    
    @ObservedObject var searchViewModel: SearchViewModel
    
    var body: some View {
        
        LazyVStack {
            ForEach(searchViewModel.artists.indices, id: \.self) { index in
                HStack {
                    AsyncImage(url: searchViewModel.artists[index].imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 5)
                    }
                    .frame(width: 50, height: 50)
                    Text(searchViewModel.artists[index].inform)
                    Spacer()
                }
                Divider()
            }
        }
        
    }
}

