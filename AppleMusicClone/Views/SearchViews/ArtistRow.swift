//
//  ArtistRow.swift
//  AppleMusicClone
//
//  Created by Hankyu Lee on 2022/07/07.
//

import SwiftUI

struct ArtistRow: View {
    
    @StateObject var searchVM: SearchViewModel
    
    var body: some View {
        
        LazyVStack {
            ForEach(searchVM.artists.indices, id: \.self) { index in
                HStack {
                    AsyncImage(url:
                                searchVM.artists[index].imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 5)
                    }
                    .frame(width: 50, height: 50)
                    Text(searchVM.artists[index].inform)
                    Spacer()
                }
            }
        }
        
    }
}
