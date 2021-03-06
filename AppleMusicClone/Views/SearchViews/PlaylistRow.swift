//
//  PlaylistRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import SwiftUI

struct PlaylistRow: View {
    @ObservedObject var searchViewModel: SearchViewModel

    var body: some View {
        LazyVStack {
            ForEach(searchViewModel.playlists.indices, id: \.self) { index in
                HStack {
                    AsyncImage(url: searchViewModel.playlists[index].imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 5)
                    }
                    .frame(width: 50, height: 50)
                    Text(searchViewModel.playlists[index].inform)
                    Spacer()
                }
                Divider()
            }
        }
    }
}
