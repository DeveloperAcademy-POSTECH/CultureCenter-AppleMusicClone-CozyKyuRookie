//
//  SongRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import SwiftUI

struct SongRow: View {
    
    @StateObject var searchVM: SearchViewModel
    
    var body: some View {
        
        LazyVStack {
            ForEach(searchVM.songs.indices, id: \.self) { index in
                HStack {
                    AsyncImage(url:searchVM.songs[index].imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 5)
                    }
                    .frame(width: 50, height: 50)
                    Text(searchVM.songs[index].inform)
                    Spacer()
                }
            }
        }
        
    }
}
